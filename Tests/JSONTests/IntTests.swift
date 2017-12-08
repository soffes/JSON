//
//  IntTests.swift
//  JSON
//

import XCTest
import JSON

struct IntModel: Equatable {
	let id: Int64
}

extension IntModel: JSONDeserializable {
	init(jsonRepresentation dictionary: JSONDictionary) throws {
		id = try decode(dictionary, key: "id")
	}
}

func ==(lhs: IntModel, rhs: IntModel) -> Bool {
	return lhs.id == rhs.id
}

final class IntTests: XCTestCase {
	
	
	func testDeserializeDictionary() throws {
		let expected = IntModel(id: 1234)
		let dictionary: JSONDictionary = [
			"id": 1234
		]
		
		XCTAssertEqual(expected, try decode(dictionary))
	}
	
	func testDeserializeData() throws {
		let expected = IntModel(id: 1234)
		
		let data = "{\"id\": 1234}".data(using: .utf8)!
		
		let json = try JSONSerialization.jsonObject(with: data, options: []) as! JSONDictionary
		
		XCTAssertEqual(expected, try decode(json))
	}
	
}
