//
//  SequenceExtensions.swift
//  <Your Project Name Here…>
//
//  Created by Murali Kishan Bhat on 3/19/17.
//  Copyright © 2017 EXILANT. All rights reserved.
//

/* Swift Sequence Extensions

# Swift Sequence Extensions


*/

import Foundation


// MARK: - last(where: <predicate>)
// Method to find the last element in a sequence which meets the predicate closure criteria
// E.g.:
//
//let names = ["Paula", "Elena", "Zoe"]
//let lastNameEndingWithA = names.last{$0.hasSuffix("a")}
//print(lastNameEndingWithA)

extension Sequence {
	func last(where predicate: (Iteratore.Element) -> Bool) -> Iterator.Element? {
		for element in reversed() where predicate(element) {
			return element
		}
		return nil
	}
}


// MARK: - all(matching:)
// Returns true if all the elements match the predicate
// Trick used is to revert the condition and find at least one element which does not match the predicate
// This reduces the processing time
// E.g.:
//
//let evenNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].filter{$0 % 2 == 0}
//print(evenNumbers.all{$0 % 2 == 0})

extension Sequence {
	
	func all(matching predicate: (Iterator.Element)->Bool) -> Bool {
		// Every element matches a predicate if no element doesn't match it:
		return !contains {!predicate($0)}
	}
}



// MARK: - accumulate(_, using)
// Returns a new array with result getting accumulated into the new array by applying the closure on each element of the array
// E.g.:
//
// print([1, 2, 3, 4, 5].accumulate(0, using: +))
extension Array {
	
	func accumulate<Result>(_ initialResult: Result, using nextPartialResult: (Result, Element)->Result) -> [Result] {
		var running = initialResult
		return map { next in
			running = nextPartialResult(running, next)
			return running
		}
	}
}

// MARK: - filter(_:(Element)->Bool)
// Returns a new array with result contining elements matching the criteria
// E.g.:
//
// print([1, 2, 3, 4, 5].filter{$0 % 2 == 0}

extension Array {
	func filter(_ isIncluded: (Element) -> Bool) -> [Element] {
		var result: [Element] = []
		for x in self where isIncluded(x) {
			result.append(x)
		}
		return result
	}
}
