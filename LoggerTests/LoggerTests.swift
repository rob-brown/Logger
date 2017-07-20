//
// LoggerTests.swift
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

import XCTest
@testable import Logger

class LoggerTests: XCTestCase {

    var factory = LoggerFactory()

    override func setUp() {
        factory = LoggerFactory()
    }

    func testLoggerNamed() {
        XCTAssert(factory.logger(named: "testLoggerNamed") === factory.logger(named: "testLoggerNamed"))
        XCTAssertEqual(factory.loggerNames, ["testLoggerNamed"])
    }

    func testLog() {
        let logger = factory.logger(named: "testLog")
        let backend = SpyBackend()
        logger.settings = LoggerSettings(original: logger.settings, level: .debug, backend: backend)
        logger.error("This is an error log")
        logger.warn("This is a warn log")
        logger.info("This is an info log")
        logger.debug("This is a debug log")
        logger.log(string: "This should never be seen.", level: .disable)

        let expected = [
            "[testLog:ERROR]: This is an error log",
            "[testLog:WARN]: This is a warn log",
            "[testLog:INFO]: This is an info log",
            "[testLog:DEBUG]: This is a debug log",
        ]

        XCTAssertEqual(backend.logs, expected)
    }

    func testLogLevel() {
        let logger = factory.logger(named: "testLogLevel")
        let backend = SpyBackend()
        logger.settings = LoggerSettings(original: logger.settings, level: .warn, backend: backend)
        logger.error("This is an error log")
        logger.warn("This is a warn log")
        logger.info("This is an info log")
        logger.debug("This is a debug log")
        logger.log(string: "This should never be seen.", level: .disable)

        XCTAssertEqual(backend.logs, ["[testLogLevel:ERROR]: This is an error log", "[testLogLevel:WARN]: This is a warn log"])
    }

    func testDisabledLogs() {
        let logger = factory.logger(named: "testDisabledLogs")
        let backend = SpyBackend()
        logger.settings = LoggerSettings(original: logger.settings, level: .disable, backend: backend)
        logger.error("This is an error log")
        logger.warn("This is a warn log")
        logger.info("This is an info log")
        logger.debug("This is a debug log")
        logger.log(string: "This should never be seen.", level: .disable)

        XCTAssertEqual(backend.logs, [])
    }

    func testLogEmptyString() {
        let logger = factory.logger(named: "testLogEmptyString")
        let backend = SpyBackend()
        logger.settings = LoggerSettings(original: logger.settings, level: .debug, backend: backend)
        logger.error("")
        logger.warn("")
        logger.info("")
        logger.debug("")
        logger.log(string: "", level: .disable)

        XCTAssertEqual(backend.logs, [])
    }
}
