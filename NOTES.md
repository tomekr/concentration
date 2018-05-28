# Developing ios 11 Applications in Swift

## Lecture 1: Introduction to iOS 11, Xcode 9 and Swift 4

Swift is a strongly typed language

Command+Click code in editor to rename something that is also connected to the UI

## Lecture 2: MVC

The Model and View should never speak to each other

View uses delegates as callbacks (should, will, did)

The model can use a radio station to broadcast changes that the controller can pick up via receivers and do some action based on that change
    * In iOS this is called Notification and KVO

In Swift, Structs and Classes are VERY similar

main differences:

1. Structs have no inheritance
2. Structs are value types, Classes are reference types
    * value types are copied (copy on write semantics)
    * reference types are pointers


classes get a free init as long as all of their variables are initialized

struct gets a free initializer too 


Binaries/Frameworks can be added in the build config


## Assignment 1: Concentration

[PDF](https://itunesu-assets.itunes.apple.com/apple-assets-us-std-000001/CobaltPublic118/v4/04/b5/81/04b58115-f130-54e7-e23d-020840f92932/311-6986826354385551794-CS193P_F17_Assignment_1_iTunesU.pdf)


## Lecture 3: Swift Programming Language

UI Stack view (just another class like UIButton, UILabel)

* takes other views and stacks them together. Only knows horizontal OR vertical

Going over stacking UI elements and doing a more consistent view

How do you create a CountableRange from floating point numbers?

* there is a global function called `stride`

A typle is nothing more that a grouping of values

* Example: `let x: (String, Int, Double) = ("hello", 5, 0.85)`
* good for returning multiple values from a function since Swift only allows you to return a single item

### Access Control

There are keywords you can use when defining, for example, your model API that states ("I will not change this API in a way that will break it"). This makes things like large development possible where you may have one whole team working on the model and another team just working on the ViewController.

* `internal`: this is the default, it means "usable by any object in my app or framework"
    * we don't normally type this
* `private`: "only callable from within this object"
* `private(set)`: "this property is readable outside of this object, but not settable"
* `fileprivate`: accessible by any code in this source file
* `public`: (for frameworks only) this can be used by objects outside my framework
* `open`: (for frameworks only) public and objects outside my framework can subclass this

### Extensions

Allows you to extend existing data structures


### enum

```swift
enumm FastFoodMenuItem {
	case hamburger(numberOfPatties: Int)
	case fries(size: FryOrderSize)
	case drink(String, ounces: Int)
	case cookie
}
```

enums, like structs get copied as they get passed around

Enums in swift are a little more powerful because each case can also have associated data.

Swift requires you to check every single state when using a switch statement to check the state of an item

Enums can have methods or vars but no storage

### Optionals

An Optional is just an `enum`. It essentially looks like:

```swift
enum Optional<T> {
	case none
	case some(<T>)
}
```

## Lecture 4

Making Concentration a `struct`

### Data Structures: `protocol`

A Basically a list of methods and vars with no implementation

* No data storage

What are protocols good for:

* Making API more flexible and expressive
* Super good for blind, structured communication between View and Controller (delegation)
* Mandating behavior (e.g. the keys of a Dictionary must be hashable)

There are 3 aspects to a protocol:

1. the protocol declaration (which properties and methods are in the protocol?)
2. a class, struct, or enum declaration that makes the **claim** to implement the protocol
3. the **code** in said class, struct, or enum (or extension) that implements the protocol

How to declare a prototype:

```swift
protocol SomeProtocol : InheritedProtocol1, InheritedProtocol2 {
	var someProperty: Int { get set }
	func aMethod(arg1: Double, anotherArgument: String) -> SomeType
	// Any functions that are expected to mutate the receiver should
	// be marked mutating
	mutating fun changeIt()
	init(arg: Type)
}
```

Here is how a class would implement that protocol:

```swift
class SomeClass : SuperclassOfSomeClass, SomeProtocol, AnotherProtocol {
	// implementation of SomeClass here which must include all
	// the properties and methods in SomeProtocol & AnotherProtocol
}
```

MVC Delegation is a very important use of Protocols

Protocols can support default implementations through Extensions

### String

A String is made up of Unicodes, but there's also the concept of a **Character**. A Characte is wht ahuman would perceive to be a single lexical ccharacter. This is true even if a single Character is made up of multiple Unicodes.

Strings are indexed by their own special type, `String.Index`

### Function Types

### Closures

Often you want to create the function "on the fly" (rather than already-existing like sqrt). You can do this "in line" using a closure.

Imagine we had a function that changed the sign of its argument

```swift
func changeSign(operand: Double) -> Double { return -operand }
```

Using a Function Type we could do:

```swift
var operation: (Double) -> Double
operation = changeSign
let result = operation(4.0) // result will be -4.0
```

but with a closure we could do:

```swift
var operation: (Double) -> Double
operation = { -$0 } // $0 represents the first param passed to the closure
let result = operation(4.0) // result will be -4.0

```

A map is a good example of using a closure

Closures are also useful for property initialization

```swift
var someProperty: Type = {
	// construct the value of someProperty here
	return <the constructed value>
}()
```

This is especially useful with lazy property initialization

## Lecture 5: More Swift

### Thrown Errors

Methods can throw errors which can be seen because the method signature contains the syntax `throws`.

```swift
do {
	try context.save() // In this case save can throw
} catch let error {
	// error will be something that implements the Error protocol, e.g. NSError
	// usually these are enums that have associated values to get error details
	throw error // this would re-throw the error (only ok if the methed we are in throws)
}
```

### Any and AnyObject

There for backwards compatability with Obj-C, should pretty much avoid using it at all costs

In Swift, you can't normally send messages to an object that is of type Any

### Other Interesting Classes

* `NSObject`
* `NSNumber`
* `Date`
* `Data`: A value type "bag of bits". Used to save/restore/transmit raw data throughout the iOS SDK

### Views

* A view (i.e. `UIView` subclass) represents a rectangular area
* Hierarchical
	* A view has only one superview ... `var superview: UIView?
	* But it can have many (or zero) subviews ... `var subviews: [UIView]
	* Order in the subviews array matters

* The hierarchy is most often constructed in Xcode graphically

### Initializing a UIView

* Try to avoid an initializer if possible
	* But having one in UIView is slightly more common than having a `UIViewController` initializer
* A UIView's initializer is different if it comes out of a storyboard
  
  ```swift
  init(frame: CGRecrt) // UIView is created in code
  init(coder: NSCoder) // UIViews comes out of a storyboard
  ```

### Gestures

