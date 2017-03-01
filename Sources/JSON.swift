//
//  JSON.swift
//  JSON
//
//  Created by Sam Soffes on 9/22/16.
//  Copyright © 2016 Sam Soffes. All rights reserved.
//

/// JSON dictionary type alias.
///
/// Strings must be keys.
public typealias JSONDictionary = [String: Any]


/// Protocol for things that can be deserialized with JSON.
public protocol JSONDeserializable {
	/// Initialize with a JSON representation
	///
	/// - parameter jsonRepresentation: JSON representation
	/// - throws: JSONError
	init(jsonRepresentation: JSONDictionary) throws
}


public protocol JSONSerializable {
	/// JSON representation
	var jsonRepresentation: JSONDictionary { get }
}


/// Errors for deserializing JSON representations
public enum JSONDeserializationError: Error {
	/// A required attribute was missing
	case missingAttribute(key: String)

	/// An invalid type for an attribute was found
	case invalidAttributeType(key: String, expectedType: Any.Type, receivedValue: Any)

	/// An attribute was invalid
	case invalidAttribute(key: String)
}
