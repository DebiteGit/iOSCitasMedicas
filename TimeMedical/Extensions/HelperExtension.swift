//
//  HelperExtension.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 18/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar

extension UIView {
	
	/**
	Adds a vertical gradient layer with two **UIColors** to the **UIView**.
	- Parameter topColor: The top **UIColor**.
	- Parameter bottomColor: The bottom **UIColor**.
	*/
	
	func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) -> CAGradientLayer{
		let gradient = CAGradientLayer()
		gradient.frame = self.bounds
		gradient.colors = [
			topColor.cgColor,
			bottomColor.cgColor
		]
		gradient.locations = [0.0, 1.0]
		gradient.startPoint = CGPoint(x: 0, y: 0)
		gradient.endPoint = CGPoint(x: 0, y: 1)
		
		return gradient
	}
	
}

extension UIViewController {
	func alert(title: String, message: String) {
		// create the alert
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
		
		// add an action (button)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
		
		// show the alert
		self.present(alert, animated: true, completion: nil)
	}
}

extension UIColor {
	convenience init(colorWithHexValue value: Int, alpha :CGFloat = 1.0) {
		self.init(
			red : CGFloat((value & 0xFF0000) >> 16) / 255.0,
			green : CGFloat((value & 0x00FF00) >> 16) / 255.0,
			blue : CGFloat((value & 0x0000FF) >> 16) / 255.0,
			alpha: alpha
		)
	}
}
