//
//  JSON+URL.swift
//  JSON
//
//  Created by Sam Soffes on 3/1/17.
//  Copyright © 2017 Sam Soffes. All rights reserved.
//

import Foundation

/// Decode a URL value from a given JSON dictionary.
///
/// - parameter dictionary: a JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: The expected value
/// - throws: JSONDeserializationError
public func decode(_ dictionary: JSONDictionary, key: String) throws -> URL {
	guard let string = dictionary[key] as? String else {
		throw JSONDeserializationError.missingAttribute(key: key)
	}

	if let url = URL(string: string) {
		return url
	}

	throw JSONDeserializationError.invalidAttributeType(key: key, expectedType: URL.self, receivedValue: string)
}
