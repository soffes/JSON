extension Dictionary where Key : StringProtocol {
	/// Generically decode an value from a given JSON dictionary.
	///
	/// - parameter key: key in the dictionary
	/// - returns: The expected value
	/// - throws: JSONDeserializationError
	public func decode<T>(key: Key) throws -> T {
		guard let value = self[key] else {
			throw JSONDeserializationError.missingAttribute(key: String(key))
		}

		guard let attribute = value as? T else {
			throw JSONDeserializationError.invalidAttributeType(key: String(key), expectedType: T.self,
																receivedValue: value)
		}

		return attribute
	}

	/// Decode a JSONDeserializable type from a given JSON dictionary.
	///
	/// - parameter key: key in the dictionary
	/// - returns: The expected JSONDeserializable value
	/// - throws: JSONDeserializationError
	public func decode<T: JSONDeserializable>(key: Key) throws -> T {
		let json: JSON = try decode(key: key)
		return try T.init(json: json)
	}

	/// Decode an array of JSONDeserializable types from a given JSON dictionary.
	///
	/// - parameter key: key in the dictionary
	/// - returns: The expected JSONDeserializable value
	/// - throws: JSONDeserializationError
	public func decode<T: JSONDeserializable>(key: Key) throws -> [T] {
		let values: [JSON] = try decode(key: key)
		return values.flatMap { try? T.init(json: $0) }
	}
}
