//
//  Post.swift
//  JSON
//
//  Created by Sam Soffes on 9/22/16.
//  Copyright © 2016 Sam Soffes. All rights reserved.
//

import Foundation
import JSON

struct Post: Equatable {
	let title: String
	let author: User
}


extension Post: JSONDeserializable {
	init(jsonRepresentation dictionary: JSONDictionary) throws {
		title = try decode(dictionary, key: "title")
		author = try decode(dictionary, key: "author")
	}
}


func ==(lhs: Post, rhs: Post) -> Bool {
	return lhs.title == rhs.title && lhs.author == rhs.author
}
