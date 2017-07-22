//
//  SequenceExtensions.swift
//  <Your Project Name Here…>
//
//  Created by Murali Kishan Bhat on 3/19/17.
//  Copyright © 2017 EXILANT. All rights reserved.
//

/* Swift sequence extensions

# Swift Sequence Extensions


*/

import Foundation

//MARK: - |> operator
// --------
// |> operator
precedencegroup LeftFunctionalApply {
	associativity: left
	higherThan: AssignmentPrecedence
	lowerThan: TernaryPrecedence
}

infix operator |> : LeftFunctionalApply

func |> <In, Out>(lhs: In, rhs: (In) throws -> Out) rethrows -> Out {
	return try rhs(lhs)
}


