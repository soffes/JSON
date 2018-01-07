import Foundation

extension Dictionary where Key : StringProtocol {
	/// Decode a date value from a given JSON dictionary. ISO8601 or Unix timestamps are supported.
	///
	/// - parameter key: key in the dictionary
	/// - returns: The expected value
	/// - throws: JSONDeserializationError
	public func decode(key: Key) throws -> Date {
		let value: Any = try decode(key: key)

		if #available(OSXApplicationExtension 10.12, iOSApplicationExtension 10.0, watchOSApplicationExtension 3.0,
			tvOSApplicationExtension 10.0, *), let string = value as? String
		{
			guard let date = ISO8601DateFormatter().date(from: string) else {
				throw JSONDeserializationError.invalidAttribute(key: String(key))
			}

			return date
		}

		if let timeInterval = value as? TimeInterval {
			return Date(timeIntervalSince1970: timeInterval)
		}

		if let timeInterval = value as? Int {
			return Date(timeIntervalSince1970: TimeInterval(timeInterval))
		}

		throw JSONDeserializationError.invalidAttributeType(key: String(key), expectedType: String.self,
															receivedValue: value)
	}
}
