//
//  MenuViewController.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 18/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
	
	var gradientLayer = CAGradientLayer()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		gradientLayer = view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
		
		view.layer.insertSublayer(gradientLayer, at: 0)
		gradientLayer.frame = view.bounds
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		gradientLayer.frame = view.bounds
	}
	
}
