# JSON

[![Version](https://img.shields.io/github/release/soffes/JSON.svg)](https://github.com/soffes/JSON/releases)
[![Build Status](https://travis-ci.org/soffes/JSON.svg?branch=master)](https://travis-ci.org/soffes/JSON)
![Swift Version](https://img.shields.io/badge/swift-4.0-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Micro framework for easily parsing JSON in Swift with rich error messages in less than 100 lines of code.

> *infomercial voice* 🎙 Are you tried of parsing JSON and not knowing what went wrong? Do you find complicated frameworks with confusing custom operators a hassle? Are you constantly wishing this could be simpler? Well now it can be, with JSON! Enjoy the Simple™


## Usage

Let’s say we have a simple user struct:

``` swift
struct User {
    let name: String
    let createdAt: Date
}
```


### Deserializing Attributes

We can add JSON deserialization to this really easily:

``` swift
extension User: JSONDeserializable {
    init(json: JSON) throws {
        name = try json.decode(key: "name")
        createdAt = try json.decode(key: "created_at")
    }
}
```

(`JSON` is simply a typealias for `[String: Any]`.)

Notice that you don’t have to specify types! This uses Swift generics and pattern matching so you don’t have to worry about this. The interface for those decode functions look like this:

``` swift
func decode<T: JSONDeserializable>(key: String) throws -> T
func decode<T: JSONDeserializable>(key: String) throws -> [T]
func decode(key: String) throws -> Date
func decode(key: String) throws -> URL
```

There’s a specialized verion that returns a `Date`. You can supply your own functions for custom types if you wish.

Here’s deserialization in action:

``` swift
let json = [
    "name": "Sam Soffes",
    "created_at": "2016-09-22T22:28:37+02:00"
]

let sam = try User(json: json)
```

### Optional Attributes

Decoding an optional attribute is easy:

``` swift
struct Comment {
    let body: String
    let publishedAt: Date?
}

extension Comment {
    init(json: JSON) throws {
        body = try json.decode(key: "body")

        // See how we use `try?` to just get `nil` if it fails to decode?
        // Easy as that!
        publishedAt = try? json.decode(key: "published_at")
    }
}
```

### Deserializing Nested Dictionaries

Working with nested models is easy. Let’s say we have the following post model:

``` swift
struct Post {
    let title: String
    let author: User
}

extension Post: JSONDeserializable {
    init(json: JSONDictionary) throws {
        title = try json.decode(key: "title")
        author = try json.decode(key: "author")
    }
}
```

We can simply treat a nested model like any other kind of attribute because there’s a generic function constrainted to `JSONDeserializable` and `User` in our example conforms to that.


### Deserializing Enums

Enums that are `RawRepresentable`, meaning they have an underlying type and no associated values, will deserialize with any additional work! Let’s say we have the following enum:

```swift
enum RelationshipStatus: String {
    case stranger
    case friend
    case blocked
}
```

We could simply deserialize it like this assuming our `User` example earlier now has a property for it:

```swift
let json = [
    "name": "Sam Soffes",
    "created_at": "2016-09-22T22:28:37+02:00",
    "releationship_status": "friend"
]

extension User: JSONDeserializable {
    init(json: JSON) throws {
        name = try json.decode(key: "name")
        createdAt = try json.decode(key: "created_at")
        relationshipStatus = try json.decode("relationship_status")
    }
}
```

If your enum isn’t `RawRepresentable`, see the next section for providing a custom `decode` method for it.

### Deserializing Custom Types

You can also define custom `decode` function for custom types very easily. We’ll use `TimeZone` as an example:

``` swift
extension Dictionary where Key : StringProtocol {
    func decode(key: Key) throws -> TimeZone {
        // Get the JSON representation of it. Here, it’s a string.
        let string: String = try decode(key: key)

        // Initialize TimeZone with the identifier you decoded already.
        guard let timeZone = TimeZone(identifier: string) else {
            throw JSONDeserializationError.invalidAttribute(key: String(key))
        }

        return timeZone
    }
}
```

Then you can do `try json.decode(key: "timezone")` like normal and it will throw the appropriate errors for you or decode a valid `TimeZone` value.

How cool is that‽
