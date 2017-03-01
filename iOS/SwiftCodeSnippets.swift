//
//  AppStoryboard.swift
//  <Your Project Name Here…>
//
//  Created by Murali Kishan Bhat on 2/9/17.
//  Copyright © 2017 EXILANT. All rights reserved.
//

import UIKit

//------------------------------------------------------------------------------
// MARK: From Ritesh Gupta - https://medium.com/@_riteshhh


// MARK: preferredStatusBarStyle
// Ensures that the current view controller's status bar style overrides the
// default one from the UIViewController base class

extension UINavigationController {
	open override var preferredStatusBarStyle: UIStatusBarStyle {
		return topViewController?.preferredStatusBarStyle ?? .default
	}
}

// MARK: dequeueCell…
// Easy way to get customcell’s reference without force casting
// Usage:
//let cell: CustomCell = table.dequeueCell(withIdentifier: identifier,
//											for: indexPath)
extension UITableView {
	
	func dequeueCell<T: UITableViewCell>(withIdentifier identifier: String, for indexPath: IndexPath) -> T {
		return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
	}
}


// MARK: Describable - typeName
// typeName used as easy way to describe a class, struct, enum,…
// All the Swift developers who keep their cell’s reuse identifier same as their
// cell’s class name they can very much relate how this snippet could be useful!

protocol Describable	{
	var typeName: String { get }
	static var typeName: String { get }
}

extension Describable {
	var typeName: String {
		return String(describing: self)
	}
	
	static var typeName: String {
		return String(describing: self)
	}
}

extension Describable where Self: NSObjectProtocol {
	var typeName: String {
		let type = type(of: self)
		return String(describing: type)
	}
}

// MARK: Generic typealias for closure
// Closure for generic type returning Void
// Usage:
//let intClosure: Closure<Int> = { intValue in
//	...
//}
//intClosure(10)
typealias Closure<T> = (T) -> Void


// MARK: not Method on Bool to reverse its value
// Usage: 
//func logic() -> Bool {
//	let someBool: Bool?
//	return someBool?.not ?? false
//}
extension Bool {
	var not: Bool {
		return !self
	}
}

// MARK: not on Optional - returns reverse value if Bool else nil
// creates a not property on an optional variable which in case of a bool return
// its opposite value and otherwise it returns a false.
// Usage:
// let someBool: Bool? = nil
// someBool.not // false
// let someBool: Bool? = false
// someBool.not // true

extension Optional {
	
	var not: Bool {
		switch self {
		case .none:
			return false
		case .some(let wrapped):
			if let value = wrapped as? Bool {
				return !value
			} else {
				return false
			}
		}
	}
}

// MARK: after, before, index(before:) methods on Collections
// Makes accessing after & before element in a collection way easier. If the
// subsequent element doesn’t exist then it simply returns nil.
// Usage:
// let list = ["a", "b", "c", "d"]
// list.after("a")	// "b"
// list.before("c")	// "b"
// list.after("d")	// nil
public extension Collection where Iterator.Element: Equatable {
	
	public func after(_ element: Iterator.Element) -> Iterator.Element? {
		guard let idx = index(of: element), index(after: idx) < endIndex else { return nil }
		let nextIdx = index(after: idx)
		return self[nextIdx]
	}
	
	public func before(_ element: Iterator.Element) -> Iterator.Element? {
		guard let idx = index(of: element), index(before: idx) >= startIndex else { return nil }
		let previousIdx = index(idx, offsetBy: -1)
		return self[previousIdx]
	}
	
	public func index(before idx: Index) -> Index {
		return index(idx, offsetBy: -1)
	}
}

// MARK: then closure - Executes only if a value exists
// An extension on Optional & created a function then which executes a closure
// having its unwrapped value only if some exists!
// Usage:
//let name: String? = "Ritesh"
//name.then { print($0) }

extension Optional {
	// `then` function executes the closure if there is some value
	func then(_ handler: (Wrapped) -> Void) {
		switch self {
		case .some(let wrapped): return handler(wrapped)
		case .none: break
		}
	}
}


//------------------------------------------------------------------------------
// MARK: - associatedtype - https://medium.com/the-traveled-ios-developers-guide/swift-keywords-v-3-0-1-f59783bf26c#.prtko1ref

//protocol Entertainment
//{
//	associatedtype MediaType
//}
//class Foo : Entertainment
//{
//	typealias MediaType = String //Could be any type to fit the need
//}
//------------------------------------------------------------------------------
