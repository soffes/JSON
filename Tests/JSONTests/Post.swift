import Foundation
import JSON

struct Post: Equatable {
	enum State: String {
		case draft
		case published
	}

	let title: String
	let author: User
	let state: State

	static func == (lhs: Post, rhs: Post) -> Bool {
		return lhs.title == rhs.title && lhs.author == rhs.author && lhs.state == rhs.state
	}
}

extension Post: JSONDeserializable {
	init(json: JSON) throws {
		title = try json.decode(key: "title")
		author = try json.decode(key: "author")
		state = try json.decode(key: "state")
	}
}
