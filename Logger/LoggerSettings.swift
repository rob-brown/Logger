//
// LoggerSettings.swift
//
// Copyright (c) 2017 Robert Brown
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

public enum LoggerLevel: Int, CustomStringConvertible, Comparable {
    case disable = 0
    case error = 1
    case warn = 2
    case info = 3
    case debug = 4

    public var description: String {
        switch self {
        case .disable: return "DISABLE"
        case .error:   return "ERROR"
        case .warn:    return "WARN"
        case .info:    return "INFO"
        case .debug:   return "DEBUG"
        }
    }

    public static func <(lhs: LoggerLevel, rhs: LoggerLevel) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}

public struct LoggerSettings {

    public let level: LoggerLevel
    public let backend: LoggerBackend
    public let formatter: LoggerFormatter

    public init(level: LoggerLevel = .warn, backend: LoggerBackend = ConsoleBackend(), formatter: LoggerFormatter = StandardFormatter()) {
        self.level = level
        self.backend = backend
        self.formatter = formatter
    }

    public init(original: LoggerSettings, level: LoggerLevel? = nil, backend: LoggerBackend? = nil, formatter: LoggerFormatter? = nil) {
        self.level = level ?? original.level
        self.backend = backend ?? original.backend
        self.formatter = formatter ?? original.formatter
    }
}
