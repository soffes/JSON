import Foundation
import JSON

struct Blog: Equatable {
	let title: String
	let posts: [Post]

	static func == (lhs: Blog, rhs: Blog) -> Bool {
		return lhs.title == rhs.title && lhs.posts == rhs.posts
	}
}

extension Blog: JSONDeserializable {
	init(json: JSON) throws {
		title = try json.decode(key: "title")
		posts = try json.decode(key: "posts")
	}
}
