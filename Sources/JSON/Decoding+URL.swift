import Foundation

extension Dictionary where Key : StringProtocol {
	/// Decode a URL value from a given JSON dictionary.
	///
	/// - parameter key: key in the dictionary
	/// - returns: The expected value
	/// - throws: JSONDeserializationError
	public func decode(key: Key) throws -> URL {
		let string: String = try decode(key: key)

		guard let url = URL(string: string) else {
			throw JSONDeserializationError.invalidAttributeType(key: String(key), expectedType: URL.self,
																receivedValue: string)
		}

		return url
	}
}
