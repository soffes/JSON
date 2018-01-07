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
	init(jsonRepresentation dictionary: JSONDictionary) throws {
		title = try decode(dictionary, key: "title")
		posts = try decode(dictionary, key: "posts")
	}
}
