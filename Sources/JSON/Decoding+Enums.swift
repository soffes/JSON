import Foundation

extension Dictionary where Key : StringProtocol {
	/// Decode a `RawRepresentable` enum value from a given JSON dictionary.
	///
	/// - parameter key: key in the dictionary
	/// - returns: The expected value
	/// - throws: JSONDeserializationError
	public func decode<T: RawRepresentable>(key: Key) throws -> T {
		let string: T.RawValue = try decode(key: key)

		guard let value = T(rawValue: string) else {
			throw JSONDeserializationError.invalidAttributeType(key: String(key), expectedType: T.RawValue.self,
																receivedValue: string)
		}

		return value
	}
}
