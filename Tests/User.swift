//
//  User.swift
//  JSON
//
//  Created by Sam Soffes on 9/22/16.
//  Copyright © 2016 Sam Soffes. All rights reserved.
//

import Foundation
import JSON

struct User: Equatable {
	let name: String
}


extension User: JSONDeserializable {
	init(jsonRepresentation dictionary: JSONDictionary) throws {
		name = try decode(dictionary, key: "name")
	}
}


func ==(lhs: User, rhs: User) -> Bool {
	return lhs.name == rhs.name
}
