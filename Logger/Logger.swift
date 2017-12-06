//
// Logger.swift
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

public final class Logger {

    public let name: String
    public var settings: LoggerSettings

    public init(name: String, settings: LoggerSettings) {
        self.name = name
        self.settings = settings
    }

    public func debug(_ string: String, metadata: [String:Any] = [:]) {
        log(string: string, level: .debug, metadata: metadata)
    }

    public func info(_ string: String, metadata: [String:Any] = [:]) {
        log(string: string, level: .info, metadata: metadata)
    }

    public func warn(_ string: String, metadata: [String:Any] = [:]) {
        log(string: string, level: .warn, metadata: metadata)
    }

    public func error(_ string: String, metadata: [String:Any] = [:]) {
        log(string: string, level: .error, metadata: metadata)
    }

    public func log(string: String, level: LoggerLevel, metadata: [String:Any] = [:]) {
        guard level >= settings.level && level != .disable && string.isEmpty == false else { return }

        settings.backend.log(string: string, level: level, metadata: metadata, name: name, settings: settings)
    }
}
