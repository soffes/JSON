import XCTest
import JSON

final class DateTests: XCTestCase {
	let date = Date(timeIntervalSince1970: 1474576117)

	func testISO8601() {
		let json = [
			"timezone": "2016-09-22T22:28:37+02:00",
			"utc": "2016-09-22T20:28:37Z"
		]

		XCTAssertEqual(date, try? json.decode(key: "timezone"))
		XCTAssertEqual(date, try? json.decode(key: "utc"))
	}

	func testUnixTimestamp() {
		let json = [
			"timestamp": 1474576117
		]

		XCTAssertEqual(date, try? json.decode(key: "timestamp"))
	}
}
