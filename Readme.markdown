# JSON

Micro framework for easily parsing JSON in Swift 3 with rich error messages in less than 100 lines of code.

> *infomercial voice* Are you tried of parsing JSON and not knowing what went wrong? Do you find complicated frameworks with confusing custom operators a hassle. Are you constantly wishing this could be simpler? Well now it can be, with JSON! Enjoy the Simple™


## Usage

Let's say we have a simple user struct:

``` swift
struct User {
    let name: String
    let createdAt: Date
}
```

We can add JSON deserialization to this really easily:

``` swift
extension User: JSONDeserializable {
    init(jsonRepresentation dictionary: JSONDictionary) throws {
        name = try decode(dictionary, key: "name")
        createdAt = try decode(dictionary, key: "created_at")
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

let sam = User(jsonRepresentation: dictionary)
```

Easy as that!
