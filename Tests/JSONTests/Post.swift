import Foundation
import JSON

struct Post: Equatable {
	let title: String
	let author: User

	static func == (lhs: Post, rhs: Post) -> Bool {
		return lhs.title == rhs.title && lhs.author == rhs.author
	}
}

extension Post: JSONDeserializable {
	init(json: JSON) throws {
		title = try json.decode(key: "title")
		author = try json.decode(key: "author")
	}
}
