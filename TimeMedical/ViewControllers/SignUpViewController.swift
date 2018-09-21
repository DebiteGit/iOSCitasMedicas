//
//  SigninViewController.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 20/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
	
	var gradientLayer = CAGradientLayer()
	var activityView:UIActivityIndicatorView!
	
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	
	@IBOutlet weak var signupButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		
		gradientLayer = view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
		view.layer.insertSublayer(gradientLayer, at: 0)
		gradientLayer.frame = view.bounds
		
		activityView = UIActivityIndicatorView(style: .gray)
		activityView.color = UIColor.white
		activityView.frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
		
		nameField.delegate = self
		emailField.delegate = self
		passwordField.delegate = self
		
		view.addSubview(activityView)
		
		setSignUpButton(enabled: false)
		
		nameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
		emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
		passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

    }
	
	@IBAction func SignUpAccion(_ sender: UIButton) {
		guard let name = self.nameField.text else { return }
		guard let email = self.emailField.text else { return }
		guard let pass = self.passwordField.text else { return }
		
		setSignUpButton(enabled: false)
		signupButton.setTitle("", for: .normal)
		activityView.startAnimating()
		
		print("Aqui se registra sesión")
		
		Auth.auth().createUser(withEmail: email, password: pass) { user, error in
			if error == nil && user != nil {
				print("User created!")
				Auth.auth().currentUser?.sendEmailVerification{ (error) in
					if error != nil {
						print(error)
						self.alert(title: "Error", message: "No se pudo enviar mensaje de confirmación, intente mas tarde")
						self.setSignUpButton(enabled: true)
						self.signupButton.setTitle("Sign Up", for: .normal)
						self.activityView.stopAnimating()
						return
					}else{
						self.alert(title: "Bienvenido", message: "Se ha enviado un correo de verificación para poder acceder, te esperamos :)")
					}
				}
				
				let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
				changeRequest?.displayName = name
				
				changeRequest?.commitChanges { error in
					if error == nil {
						print("User display name changed!")
						
					} else {
						print("Error: \(error!.localizedDescription)")
						self.setSignUpButton(enabled: true)
						self.signupButton.setTitle("Sign Up", for: .normal)
						self.activityView.stopAnimating()
					}
				}
				
			} else {
				self.setSignUpButton(enabled: true)
				self.signupButton.setTitle("Sign Up", for: .normal)
				self.activityView.stopAnimating()
			}
		}
		
	}
	
	@IBAction func back(_ sender: UIBarButtonItem) {
		self.dismiss(animated: true, completion: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		nameField.becomeFirstResponder()
		NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		nameField.resignFirstResponder()
		emailField.resignFirstResponder()
		passwordField.resignFirstResponder()
		nameField.endEditing(true)
		emailField.endEditing(true)
		passwordField.endEditing(true)
		NotificationCenter.default.removeObserver(self)
		super.viewWillDisappear(animated)
	}
	
	@objc func keyboardWillAppear(notification: NSNotification){
		
		activityView.center = CGPoint(x: view.center.x, y: view.center.y)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		gradientLayer.frame = view.bounds
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		// Resigns the target textField and assigns the next textField in the form.
		
		switch textField {
		case nameField:
			nameField.resignFirstResponder()
			emailField.becomeFirstResponder()
			passwordField.resignFirstResponder()
		case emailField:
			nameField.resignFirstResponder()
			emailField.resignFirstResponder()
			passwordField.becomeFirstResponder()
			break
		case passwordField:
			nameField.resignFirstResponder()
			emailField.resignFirstResponder()
			SignUpAccion(signupButton)
			break
		default:
			break
		}
		return true
	}
	
	/**
	Enables or Disables the **loginButton**.
	*/
	
	func setSignUpButton(enabled:Bool){
		if enabled{
			signupButton.setTitle("Sign Up", for: .normal)
			signupButton.alpha = 1.0
			signupButton.isEnabled =  true
		}else{
			signupButton.setTitle("Sign Up", for: .normal)
			signupButton.alpha = 0.5
			signupButton.isEnabled = false
		}
	}
	
	/**
	Enables the continue button if the **username**, **email**, and **password** fields are all non-empty.
	
	- Parameter target: The targeted **UITextField**.
	*/
	
	@objc func textFieldChanged(_ target:UITextField) {
		let name = nameField.text
		let email = emailField.text
		let password = passwordField.text
		let formFilled = email != nil && email != "" && password != nil && password != "" && name != nil && name != ""
		setSignUpButton(enabled: formFilled)
	}

}
