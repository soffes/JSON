import XCTest
import JSON

final class DateTests: XCTestCase {
	let date = Date(timeIntervalSince1970: 1474576117)

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
