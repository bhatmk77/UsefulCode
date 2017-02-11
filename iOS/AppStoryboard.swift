//
//  AppStoryboard.swift
//  <Your Project Name Here…>
//
//  Created by Murali Kishan Bhat on 2/9/17.
//  Copyright © 2017 EXILANT. All rights reserved.
//

import UIKit


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
	
	var instance: UIStoryboard {
		return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
	}
	
	
	
	func viewController<T : UIViewController>(viewControllerClass : T.Type,
	                    function : String = #function,
	                    line : Int = #line,
	                    file : String = #file) -> T {
		let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
		guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
			fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
		}
		
		return scene
	}
	
	
	
	func initialViewController() -> UIViewController? {
		return instance.instantiateInitialViewController()
	}
}

extension UIViewController {
	
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
