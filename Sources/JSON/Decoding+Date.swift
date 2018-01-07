import Foundation

/// Decode a date value from a given JSON dictionary. ISO8601 or Unix timestamps are supported.
///
/// - parameter dictionary: a JSON dictionary
/// - parameter key: key in the dictionary
/// - returns: The expected value
/// - throws: JSONDeserializationError
public func decode(_ dictionary: JSONDictionary, key: String) throws -> Date {
	guard let value = dictionary[key] else {
		throw JSONDeserializationError.missingAttribute(key: key)
	}

	if #available(OSXApplicationExtension 10.12, iOSApplicationExtension 10.0, watchOSApplicationExtension 3.0, tvOSApplicationExtension 10.0, *), let string = value as? String {
		guard let date = ISO8601DateFormatter().date(from: string) else {
			throw JSONDeserializationError.invalidAttribute(key: key)
		}

		return date
	}

	if let timeInterval = value as? TimeInterval {
		return Date(timeIntervalSince1970: timeInterval)
	}

	if let timeInterval = value as? Int {
		return Date(timeIntervalSince1970: TimeInterval(timeInterval))
	}

	throw JSONDeserializationError.invalidAttributeType(key: key, expectedType: String.self, receivedValue: value)
}
