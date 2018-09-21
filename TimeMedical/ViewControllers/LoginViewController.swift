//
//  LoginViewController.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 20/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	
	var gradientLayer = CAGradientLayer()
	var activityView:UIActivityIndicatorView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true

		gradientLayer = view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
		view.layer.insertSublayer(gradientLayer, at: 0)
		gradientLayer.frame = view.bounds
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		activityView = UIActivityIndicatorView(style: .gray)
		activityView.color = UIColor.white
		activityView.frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
		activityView.center = loginButton.center
		
		view.addSubview(activityView)
		
		setLogInButton(enabled: false)
		
		emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
		passwordTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		emailTextField.becomeFirstResponder()
		emailTextField.text=Auth.auth().currentUser?.email
		NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		
		emailTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
		emailTextField.endEditing(true)
		passwordTextField.endEditing(true)
		NotificationCenter.default.removeObserver(self)
		super.viewWillDisappear(animated)
	}
	
	/**
	Adjusts the center of the **continueButton** above the keyboard.
	- Parameter notification: Contains the keyboardFrame info.
	*/
	
	@objc func keyboardWillAppear(notification: NSNotification){

		activityView.center = CGPoint(x: view.center.x,
									  y: view.center.y)
	}
	
	/**
	Enables or Disables the **loginButton**.
	*/
	
	func setLogInButton(enabled:Bool){
		if enabled{
			loginButton.setTitle("Log In", for: .normal)
			loginButton.alpha = 1.0
			loginButton.isEnabled =  true
		}else{
			loginButton.setTitle("Log In", for: .normal)
			loginButton.alpha = 0.5
			loginButton.isEnabled = false
		}
	}
	
	@IBAction func loginAction(_ sender: UIButton) {
		guard let email = self.emailTextField.text else { return }
		guard let pass = self.passwordTextField.text else { return }
		
		emailTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
		emailTextField.endEditing(true)
		passwordTextField.endEditing(true)
		NotificationCenter.default.removeObserver(self)
		
		self.loginButton.isEnabled = false
		
		self.loginButton.setTitle("", for: .normal)
		self.activityView.startAnimating()
		
		Auth.auth().signIn(withEmail: email, password: pass) { user, error in
			if error == nil && user != nil {
				Auth.auth().currentUser?.reload(completion: {(err) in
					if Auth.auth().currentUser?.isEmailVerified == true{
						self.dismiss(animated: true, completion: nil)
					}else{
						self.loginButton.isEnabled = true
						self.alert(title: "Verifica tu correo", message: "Para acceder es necesario verificar tu cuenta mediante el correo")
					}
				})
				
			} else {
				self.alert(title: "Error de Credenciales", message: (error?.localizedDescription)!)
				print("Error logging in: \(error!)")
			}
			self.loginButton.isEnabled = true
			self.passwordTextField.text=""
			self.activityView.stopAnimating()
			self.setLogInButton(enabled: false)
		}
	}
	
	@IBAction func back(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		gradientLayer.frame = view.bounds
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		// Resigns the target textField and assigns the next textField in the form.
		
		switch textField {
		case emailTextField:
			emailTextField.resignFirstResponder()
			passwordTextField.becomeFirstResponder()
			break
		case passwordTextField:
			loginAction(loginButton)
			break
		default:
			break
		}
		return true
	}
	
	/**
	Enables the continue button if the **username**, **email**, and **password** fields are all non-empty.
	
	- Parameter target: The targeted **UITextField**.
	*/
	
	@objc func textFieldChanged(_ target:UITextField) {
		let email = emailTextField.text
		let password = passwordTextField.text
		let formFilled = email != nil && email != "" && password != nil && password != ""
		setLogInButton(enabled: formFilled)
	}
	
}
