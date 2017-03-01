//
//  enumKeyType.swift
//  
//
//  Created by Murali Kishan Bhat on 3/1/17.
//
//

import Foundation


// Useful to avoid .rawValue for enum Key Types in Dictionary
protocol KeyType {
}

// Useful to avoid .rawValue for enum Key Types in Dictionary.
// Extension to Dictionary to ensure that the subscript automatically uses the .rawValue.
extension Dictionary where Key: ExpressibleByStringLiteral {
	
	subscript(key: KeyType) -> Value? {
		get {
			return self[String(describing: key) as! Key]
		}
		set(value) {
			guard
				let value = value else {
					self.removeValue(forKey: String(describing: key) as! Key)
					return
			}
			
			self.updateValue(value, forKey: String(describing: key) as! Key)
		}
	}
}

// E.g.: Use as dict[PersonModelKey.id]. No need of .rawValue
//enum PersonModelKey: String, KeyType {
//	case id = "id"
//	case firstName = "firstName"
//	case lastName = "lastName"
//	case phoneNumber = "phoneNumber"
//	case imageData = "imageData"
//	case userID = "userId"
//}
