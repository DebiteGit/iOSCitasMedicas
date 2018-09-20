//
//  LoginViewController.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 20/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	var gradientLayer = CAGradientLayer()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true

		gradientLayer = view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
		view.layer.insertSublayer(gradientLayer, at: 0)
		gradientLayer.frame = view.bounds
    }
    
	@IBAction func back(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		gradientLayer.frame = view.bounds
	}

}
