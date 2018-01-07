import XCTest
import JSON

final class DeserializationTests: XCTestCase {

	let sam = User(name: "Sam Soffes")

	func testDeserialization() {
		let json = [
			"name": "Sam Soffes"
		]

		XCTAssertEqual(sam, try? User(json: json))
	}

	func testNestedDeserialization() {
		let json: JSON = [
			"title": "Hello World",
			"author": [
				"name": "Sam Soffes"
			]
		]

		let post = Post(title: "Hello World", author: sam)

		XCTAssertEqual(post, try? Post(json: json))
	}

	func testNestedArrayDeserialization() {
		let json: JSON = [
			"title": "My Blog",
			"posts": [
				[
					"title": "Next Post",
					"author": [
						"name": "Sam Soffes"
					]
				],
				[
					"title": "Hello World",
					"author": [
						"name": "Sam Soffes"
					]
				]
			]
		]

		let blog = Blog(title: "My Blog", posts: [
			Post(title: "Next Post", author: sam),
			Post(title: "Hello World", author: sam)
		])

		XCTAssertEqual(blog, try? Blog(json: json))
	}
}
