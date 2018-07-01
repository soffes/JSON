import XCTest
import JSON

final class URLTests: XCTestCase {
	func testValidURL() {
		let json = [
			"url": "http://example.com"
		]

		XCTAssertEqual(URL(string: "http://example.com")!, try? json.decode(key: "url"))
	}

	func testInvalidURL() {
		let json = [
			"url": "~~🍕~~"
		]

		XCTAssertThrowsError(try json.decode(key: "url") as URL)
	}
}
