//
//  AppStoryboard.swift
//  <Your Project Name Here…>
//
//  Created by Murali Kishan Bhat on 2/9/17.
//  Copyright © 2017 EXILANT. All rights reserved.
//

import Cocoa


/// Enumeration to make loading a storyboard very simple.
// Ref: https://medium.com/@gurdeep060289/clean-code-for-multiple-storyboards-c64eb679dbf6#.4cx4jva75

enum AppStoryboard: String {
	case Main
	// TODO: Place your other storyboard names here as more cases…
	// Ensure that the names match the storyboard file name.
	// Else, make sure that the right raw value is set
	// E.g.:
	// case loginStoryBoard = "Login Story Board"
	
	
	// Usage E.g.: let storyboard = AppStoryboard.Main.instance
	// Usage E.g.: let storyboard = AppStoryboard.loginStoryBoard.instance
	
	var instance: NSStoryboard {
		return NSStoryboard(name: self.rawValue, bundle: Bundle.main)
	}

	
	
	func viewController<T: NSViewController>(viewControllerClass: T.Type) -> T {
		let storyboardID = (viewControllerClass as NSViewController.Type).storyboardID
		return instance.instantiateController(withIdentifier: storyboardID) as! T
	}

	
	
	func initialViewController() -> NSViewController? {
		return instance.instantiateInitialController() as! NSViewController?
	}
}

extension NSViewController {
	
	// TODO: Override this in your class if you need a different Storyboard name
	
	class var storyboardID: String {
		return "\(self)"
	}
	
	// Sample usage:
	//	let tempVC = ViewController.instantiate(fromAppStoryboard: .Main)
	//	let tempVC = ViewController.instantiate(fromAppStoryboard: .Main)
	//	let tempVC = AppStoryboard.PreLogin.viewController(viewControllerClass: LoginVC.self)
	//	let tempVC = AppStoryboard.PreLogin.instance.instantiateViewController(withIdentifier: LoginVC.storyboardID)

	static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
		return appStoryboard.viewController(viewControllerClass: self)
	}
}
