//
//  DateTests.swift
//  JSONTests
//
//  Created by Sam Soffes on 9/22/16.
//  Copyright © 2016 Sam Soffes. All rights reserved.
//

import XCTest
import JSON

final class DateTests: XCTestCase {
	let date = Date(timeIntervalSince1970: 1474576117)

	@available(iOSApplicationExtension 10.0, OSXApplicationExtension 10.12, watchOSApplicationExtension 3.0, tvOSApplicationExtension 10.0, *)
	func testISO8601() {
		let dictionary = [
			"timezone": "2016-09-22T22:28:37+02:00",
			"utc": "2016-09-22T20:28:37Z"
		]

		XCTAssertEqual(date, try! decode(dictionary, key: "timezone"))
		XCTAssertEqual(date, try! decode(dictionary, key: "utc"))
	}

	func testUnixTimestamp() {
		let dictionary = [
			"timestamp": 1474576117
		]

		XCTAssertEqual(date, try! decode(dictionary, key: "timestamp"))
	}
}
