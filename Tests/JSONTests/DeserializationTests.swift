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
			],
			"state": "published"
		]

		let post = Post(title: "Hello World", author: sam, state: .published)

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
					],
					"state": "draft"
				],
				[
					"title": "Hello World",
					"author": [
						"name": "Sam Soffes"
					],
					"state": "published"
				]
			]
		]

		let blog = Blog(title: "My Blog", posts: [
			Post(title: "Next Post", author: sam, state: .draft),
			Post(title: "Hello World", author: sam, state: .published)
		])

		XCTAssertEqual(blog, try? Blog(json: json))
	}
	
	func testNestedErrorDeserialization() {
		let dictionary: JSONDictionary = [
			"title": "My Blog",
			"posts": [
				[
					"title": "Next Post",
					"author": [
						"name": "Sam Soffes"
					]
				],
				[
					"title": 1,
					"author": [
						"name": "Sam Soffes"
					]
				]
			]
		]

		XCTAssertThrowsError(try decode(dictionary) as Blog)
	}
}
