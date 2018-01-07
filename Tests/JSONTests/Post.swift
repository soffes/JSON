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
	init(jsonRepresentation dictionary: JSONDictionary) throws {
		title = try decode(dictionary, key: "title")
		author = try decode(dictionary, key: "author")
	}
}
