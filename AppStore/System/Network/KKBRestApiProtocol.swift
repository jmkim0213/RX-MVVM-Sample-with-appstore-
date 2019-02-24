//
//  KKBRestApi.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

private let kRestApiURL = "https://itunes.apple.com"

enum KKBHttpMethod : String {
    case options    = "OPTIONS"
    case get        = "GET"
    case head       = "HEAD"
    case post       = "POST"
    case put        = "PUT"
    case patch      = "PATCH"
    case delete     = "DELETE"
    case trace      = "TRACE"
    case connect    = "CONNECT"
    case multipart  = "MULTIPART"
}

protocol KKBRestApiProtocol {
    var baseURL         : String { get }
    var path            : String { get }
    var method          : KKBHttpMethod { get }
    var parameters      : [String: String] { get }
    var fullPath        : String { get }
    var scheduler       : SchedulerType { get }
}

extension KKBRestApiProtocol {
    var baseURL         : String { return kRestApiURL }
    var fullPath        : String { return self.baseURL + self.path }
    var scheduler       : SchedulerType { return ConcurrentDispatchQueueScheduler(queue: DispatchQueue(label: "AppStoreApi")) }

    func request<T: Decodable>(_ type: T.Type) -> Observable<T> {
        let fullPath    = self.fullPath
        let method      = self.method.rawValue

        KKBLog("fullPath: \(fullPath)")
        KKBLog("method: \(method)")
        
        guard let url = URL(string: fullPath) else { return Observable.empty() }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return Observable.empty() }
        components.queryItems = self.parameters.compactMap { URLQueryItem(name: $0, value: $1) }
        components.query = components.query?.replacingOccurrences(of: " ", with: "+")
        
        return Observable.from(optional: components.url).map {
            var request = URLRequest(url: $0)
            request.httpMethod = method
            return request
        }
        .flatMap { URLSession.shared.rx.response(request: $0).retry(3) }
        .map { (response, data) -> T in
            guard 200..<300 ~= response.statusCode else {
                throw self.unacceptableStatusCodeError(response.statusCode)
            }
            return try JSONDecoder().decode(T.self, from: data)
        }.take(1)
        .subscribeOn(self.scheduler)
        .observeOn(MainScheduler.instance)
    }
    
    private func unacceptableStatusCodeError(_ statusCode: Int) -> NSError {
        let message = "Response status code was unacceptable: \(statusCode)."
        let error = NSError(domain: "KKBRestApi", code: statusCode, userInfo: [NSLocalizedDescriptionKey: message, NSLocalizedFailureReasonErrorKey: message])
        return error
    }
}
