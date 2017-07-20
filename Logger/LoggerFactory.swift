//
// LoggerFactory.swift
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

public final class LoggerFactory {

    public var defaultSettings = LoggerSettings()

    private let queue = DispatchQueue(label: "pro.tricksofthetrade.LoggerFactory", qos: .default, attributes: [], autoreleaseFrequency: .inherit, target: nil)
    private var loggers = [String:Logger]()

    public init() {}

    public var loggerNames: [String] {
        return Array(loggers.keys)
    }

    public func logger(named name: String) -> Logger {
        // Do a dirty read for efficiency.
        if let log = loggers[name] {
            return log
        }

        var result: Logger!

        queue.sync {
            // Do a clean read to avoid race conditions.
            if let log = loggers[name] {
                result = log
            }
            // Create the logger if it really doesn't exist yet.
            else {
                let log = Logger(name: name, settings: defaultSettings)
                loggers[name] = log
                result = log
            }
        }

        return result
    }
}
