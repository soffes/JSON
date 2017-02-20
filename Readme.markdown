# JSON

[![Version](https://img.shields.io/github/release/soffes/JSON.svg)](https://github.com/soffes/JSON/releases)
[![Build Status](https://travis-ci.org/soffes/JSON.svg?branch=master)](https://travis-ci.org/soffes/JSON)
![Swift Version](https://img.shields.io/badge/swift-3.0.2-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Micro framework for easily parsing JSON in Swift 3 with rich error messages in less than 100 lines of code.

> *infomercial voice* 🎙 Are you tried of parsing JSON and not knowing what went wrong? Do you find complicated frameworks with confusing custom operators a hassle? Are you constantly wishing this could be simpler? Well now it can be, with JSON! Enjoy the Simple™


## Usage

Let's say we have a simple user struct:

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
    init(jsonRepresentation json: JSONDictionary) throws {
        name = try decode(json, key: "name")
        createdAt = try decode(json, key: "created_at")
    }
}
```

(`JSONDictionary` is simply a typealias for `[String: Any]`.)

Notice that you don't have to specify types! This uses Swift generics and pattern matching so you don't have to worry about this. The interface for those decode functions look like this:

``` swift
func decode<T>(_ dictionary: JSONDictionary, key: String) throws -> T
func decode(_ dictionary: JSONDictionary, key: String) throws -> Date
```

There's a specialized verion that returns a `Date`. You can supply your own functions for custom types if you wish.

Here's deserialization in action:

``` swift
let dictionary = [
    "name": "Sam Soffes",
    "created_at": "2016-09-22T22:28:37+02:00"
]

let sam = try User(jsonRepresentation: dictionary)
```

You can also simply do the following since user is `JSONDeserializable`.

```
let sam: User = try decode(dictionary)
```

### Optional Attributes

Decoding an optional attribute is easy:

``` swift
struct Comment {
    let body: String
    let publishedAt: Date?
}

extension Comment {
    init(jsonRepresentation json: JSONDictionary) throws {
        body = try deocde(json, key: "body")

        // See how we use `try?` to just get `nil` if it fails to decode?
        // Easy as that!
        publishedAt = try? deocde(json, key: "published_at")
    }
}
```

### Deserializing Nested Dictionaries

Working with nested models is easy. Let's say we have the following post model:

``` swift
struct Post {
    let title: String
    let author: User
}

extension Post: JSONDeserializable {
    init(jsonRepresentation json: JSONDictionary) throws {
        title = try decode(json, key: "title")
        author = try decode(json, key: "author")
    }
}
```

We can simply treat a nested model like any other kind of attribute because there's a generic function constrainted to `JSONDeserializable`. Here's the annotated implementation:

``` swift
public func decode<T: JSONDeserializable>(_ dictionary: JSONDictionary, key: String) throws -> T {
    // Decode the value like normal as a JSONDictionary. If this fails for whatever
    // reason, it will throw the appropriate errors.
    let value: JSONDictionary = try decode(dictionary, key: key)

    // Decode the model. This will call the initializer in the protocol for the
    // expected type. If decoding fails in the model, this will also throw the
    // appropriate erros.
    return try decode(value)
}
```


### Deserializing Custom Types

Let's say you have the following enum:

``` swift
enum RelationshipStatus: String {
    case stranger
    case friend
    case blocked
}
```

You could define a `decode` function for this type very easily:

``` swift
func decode(_ dictionary: JSONDictionary, key: String) throws -> RelationshipStatus {
    let string: String = try decode(dictionary, key: key)

    guard let status = RelationshipStatus(rawValue: string) else {
        throw JSONDeserializationError.invalidAttribute(key: key)
    }

    return status
}
```

Then you can do `try decode(dictionary, key: "status")` like normal and it will throw the appropriate errors for you.

How cool is that‽
