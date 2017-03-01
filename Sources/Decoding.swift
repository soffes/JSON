//
//  Decoding.swift
//  JSON
//
//  Created by Sam Soffes on 3/1/17.
//  Copyright © 2017 Sam Soffes. All rights reserved.
//

/// Generically decode an value from a given JSON dictionary.
///
/// - parameter dictionary: a JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: The expected value
/// - throws: JSONDeserializationError
public func decode<T>(_ dictionary: JSONDictionary, key: String) throws -> T {
	guard let value = dictionary[key] else {
		throw JSONDeserializationError.missingAttribute(key: key)
	}

	guard let attribute = value as? T else {
		throw JSONDeserializationError.invalidAttributeType(key: key, expectedType: T.self, receivedValue: value)
	}

	return attribute
}


/// Decode a JSONDeserializable type from a given JSON dictionary.
///
/// - parameter dictionary: a JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: The expected JSONDeserializable value
/// - throws: JSONDeserializationError
public func decode<T: JSONDeserializable>(_ dictionary: JSONDictionary, key: String) throws -> T {
	let value: JSONDictionary = try decode(dictionary, key: key)
	return try decode(value)
}


/// Decode an array of JSONDeserializable types from a given JSON dictionary.
///
/// - parameter dictionary: a JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: The expected JSONDeserializable value
/// - throws: JSONDeserializationError
public func decode<T: JSONDeserializable>(_ dictionary: JSONDictionary, key: String) throws -> [T] {
	let values: [JSONDictionary] = try decode(dictionary, key: key)
	return values.flatMap { try? decode($0) }
}


/// Decode a JSONDeserializable type
///
/// - parameter dictionary: a JSON dictionary
/// - returns: the decoded type
/// - throws: JSONDeserializationError
public func decode<T: JSONDeserializable>(_ dictionary: JSONDictionary) throws -> T {
	return try T.init(jsonRepresentation: dictionary)
}
