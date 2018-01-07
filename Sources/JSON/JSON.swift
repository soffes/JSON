/// JSON dictionary type alias.
///
/// Strings must be keys.
public typealias JSON = [String: Any]

/// Protocol for things that can be deserialized with JSON.
public protocol JSONDeserializable {
	/// Initialize with a JSON representation
	///
	/// - parameter json: JSON representation
	/// - throws: JSONDeserializationError
	init(json: JSON) throws
}

public protocol JSONSerializable {
	/// JSON representation
	var json: JSON { get }
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
