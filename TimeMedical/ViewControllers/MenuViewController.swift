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
	
	@IBOutlet var LoginView: UIView!
	@IBOutlet weak var VisualEffectView: UIVisualEffectView!
	
	var effect:UIVisualEffect!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		effect = VisualEffectView.effect
		VisualEffectView.effect = nil
		
		gradientLayer = view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
		
		view.layer.insertSublayer(gradientLayer, at: 0)
		gradientLayer.frame = view.bounds
		
		
		
		LoginView.layer.cornerRadius = 10
    }
	
	func animateIn() {
		self.view.addSubview(LoginView)
		LoginView.center = self.view.center
		
		LoginView.transform = CGAffineTransform.init(scaleX: 1.12, y: 1.12)
		LoginView.alpha = 0
		
		self.LoginView.frame = view.bounds
		
		UIView.animate(withDuration: 0.4) {
			self.VisualEffectView.effect = self.effect
			self.LoginView.alpha = 1
			self.LoginView.transform = CGAffineTransform.identity
		}
	}
	
	func animateOut() {
		UIView.animate(withDuration: 0.3, animations: {
			self.LoginView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
			self.LoginView.alpha = 0
			
			self.VisualEffectView.effect = nil
			}) { (success:Bool) in
				self.LoginView.removeFromSuperview()
			}
	}
	
	@IBAction func LoginAction(_ sender: Any) {
		animateIn()
	}
	
	@IBAction func AccesoLogin(_ sender: Any) {
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
