import Foundation
import JSON

struct User: Equatable {
	let name: String

	static func == (lhs: User, rhs: User) -> Bool {
		return lhs.name == rhs.name
	}
}

extension User: JSONDeserializable {
	init(json: JSON) throws {
		name = try json.decode(key: "name")
	}
}
