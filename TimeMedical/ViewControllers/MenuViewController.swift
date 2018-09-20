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
	
	@IBOutlet var LoginView: UIView!
	
	var effect:UIVisualEffect!
	var gradientLayer = CAGradientLayer()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		gradientLayer = view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
		
		view.layer.insertSublayer(gradientLayer, at: 0)
		gradientLayer.frame = view.bounds
		
		LoginView.layer.cornerRadius = 10
    }
	
	func animateIn() {
		self.view.addSubview(LoginView)
		LoginView.center = self.view.center
		
		LoginView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
		LoginView.alpha = 0
		
		self.LoginView.frame = view.bounds
		
		UIView.animate(withDuration: 0.4) {
			self.LoginView.alpha = 1
			self.LoginView.transform = CGAffineTransform.identity
		}
	}
	
	func animateOut() {
		UIView.animate(withDuration: 0.3, animations: {
			self.LoginView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
			self.LoginView.alpha = 0
		}) { (success:Bool) in
			self.LoginView.removeFromSuperview()
		}
	}
	
	
	
	
	@IBAction func cancelLogin(_ sender: UIButton) {
		animateOut()
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
