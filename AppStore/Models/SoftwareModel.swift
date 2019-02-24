//
//  SoftwareModel.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

struct SoftwareModel: Codable {
    var bundleId                    : String        = ""        // bundle id
    var screenshotUrls              : [String]      = []        // 미리보기 스크린샷
    
    var artworkUrl60                : String        = ""        // 앱 아이콘 60
    var artworkUrl100               : String        = ""        // 앱 아이콘 100
    var artworkUrl512               : String        = ""        // 앱 아이콘 512
    
    var trackName                   : String        = ""        // 앱 이름
    var trackContentRating          : String        = ""        // 연령 등급
    var trackViewUrl                : String        = ""        // iTunes 주소
    
    var description                 : String        = ""        // 앱 설명
    
    var averageUserRating           : Float?                    // 평균 사용자 점수
    var userRatingCount             : Int?                      // 점수 준 사용자 수
    
    var sellerName                  : String        = ""        // 판매자 이름
    var sellerUrl                   : String?                   // 판매자 URL
    
    var releaseNotes                : String?                   // 이 버전에서 개선된 사항
    var currentVersionReleaseDate   : String        = ""          // 이 버전에서 출시일
    
    var isGameCenterEnabled         : Bool          = false     // 게임센터 활성화
    var fileSizeBytes               : String        = ""        // 파일크기
    
    var primaryGenreName            : String        = ""        // 기본 카테고리
    var genres                      : [String]      = []        // 카테고리
    var formattedPrice              : String        = ""
    var minimumOsVersion            : String        = ""        // OS 버전
    var version                     : String        = ""        // 앱 버전
    
    var supportedDevices            : [String]      = []        // 호환장비
    
    var features                    : [String]      = []
}

extension SoftwareModel: Equatable {
    static func == (lhs: SoftwareModel, rhs: SoftwareModel) -> Bool {
        return lhs.bundleId == rhs.bundleId
    }
}
