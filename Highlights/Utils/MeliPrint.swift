//
//  MeliPrint.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 04/04/2022.
//

import Foundation

public class MeliPrint {

 

    // MARK: Properties

 

    /// Singleton

    public static let shared = MeliPrint()

 

    // MARK: init

    private init () {

 

    }

 

    // MARK: Methods

    fileprivate func message(_ message: String, type: MessageType = .info, filename: String, function: String, line: Int) {

 

        #if DEBUG

        let filename = (URL(fileURLWithPath: filename).lastPathComponent).replacingOccurrences(of: ".swift", with: "")

        let fileText = "\(filename)(\(line) | \(function)"

        let logText = "[Log \(type.rawValue)] [\(fileText)] -> \(message)"

 

        print("** \(logText)")

        #endif

    }

 

    public func info(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {

        self.message(message, filename: filename, function: function, line: line)

    }

    public func warning(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {

        self.message(message, type: .warning, filename: filename, function: function, line: line)

    }

    public func error(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {

        self.message(message, type: .error, filename: filename, function: function, line: line)

    }

}

 

extension MeliPrint {

    public enum MessageType: String {

        case info

        case warning

        case error

    }

}
