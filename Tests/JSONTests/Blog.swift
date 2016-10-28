//
//  Block.swift
//  JSON
//
//  Created by Sam Soffes on 10/6/16.
//  Copyright © 2016 Sam Soffes. All rights reserved.
//

import Foundation
import JSON

struct Blog: Equatable {
	let title: String
	let posts: [Post]
}


extension Blog: JSONDeserializable {
	init(jsonRepresentation dictionary: JSONDictionary) throws {
		title = try decode(dictionary, key: "title")
		posts = try decode(dictionary, key: "posts")
	}
}


func ==(lhs: Blog, rhs: Blog) -> Bool {
	return lhs.title == rhs.title && lhs.posts == rhs.posts
}
