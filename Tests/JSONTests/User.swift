import Foundation
import JSON

struct User: Equatable {
	let name: String

	static func == (lhs: User, rhs: User) -> Bool {
		return lhs.name == rhs.name
	}
}

extension User: JSONDeserializable {
	init(jsonRepresentation dictionary: JSONDictionary) throws {
		name = try decode(dictionary, key: "name")
	}
}
