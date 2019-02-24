//
//  Log.swift
//  AppStore
//
//  Created by Kim JungMoo on 26/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation

public func KKBLog(_ format: String, _ args: CVarArg..., path: String = #file, lineNumber: Int = #line, function: String = #function) {
    let format = "[\(fileName(for: path)):\(lineNumber)] \(function) > " + format
    #if DEBUG
    print(String(format: format, args))
    #endif
}

private func fileName(for path: String) -> String {
    guard let fileName = NSURL(fileURLWithPath: path).lastPathComponent else { return "unknown" }
    return fileName
}
