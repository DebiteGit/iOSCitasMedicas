//
//  HelperExtension.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 18/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import Foundation
import UIKit

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
