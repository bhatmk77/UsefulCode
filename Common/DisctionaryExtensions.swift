//
//  DisctionaryExtensions.swift
//  <Your Project Name Here…>
//
//  Created by Murali Kishan Bhat on 8/3/17.
//  Copyright © 2017 EXILANT. All rights reserved.
//

/* Swift Dictionary Extensions

# Swift Dictionary Extensions


*/

import Foundation

// To initialize a dictionary with a sequence of key value pairs
//E.g.:
// let seq = (1..<15).map {
//	(key: "Key\($0)", value: "Value\($0)")
//}
//
//let dict = Dictionary(seq)
//print(dict)

extension Dictionary {
	init<S: Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
		self = [:]
		self.myMerge(sequence)
	}
}


// To get a new dictionary with the same keys, but with transformed values (even of another type)
// E.g:
//let dict4 = dict3.mapValues {value in
//	return Int(value)!
//}
//print(dict4)

extension Dictionary {
	func mapValues<NewValue>(_ transform: (Value)->NewValue) -> [Key: NewValue] {
		return Dictionary<Key, NewValue>(map {(key, value) in
			return (key, transform(value))
		})
	}
}
