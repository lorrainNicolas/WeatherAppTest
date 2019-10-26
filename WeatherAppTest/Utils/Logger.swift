//
//  Logger.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
class Log {
    class func warning(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        Log.log(object, logEvent: .warning, filename: filename, line: line, funcName: funcName)
    }
    
    class func debug(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        Log.log(object, logEvent: .debug, filename: filename, line: line, funcName: funcName)
    }
    
    class func error(_ object: Any, filename: String = #file, line: Int = #line, funcName: String = #function) {
        Log.log(object, logEvent: .error, filename: filename, line: line, funcName: funcName)
    }
}

private extension Log {
    class func log(_ object: Any, logEvent: LogEvent, filename: String, line: Int, funcName: String) {
        print("\(logEvent.descriptionLog) \(sourceFileName(filePath: filename)):\(line) \(funcName) -> \(object)")
    }
    
    class func sourceFileName(filePath: String) -> String {
        return filePath.components(separatedBy: "/").last ?? ""
    }
    
    enum LogEvent {
        case error
        case warning
        case debug
        
        var descriptionLog: String {
            switch self {
            case .error: return "[ERROR]"
            case .warning: return "[WARNING]"
            case .debug: return "[DEBUG]"
            }
        }
    }
}
