//
//  ViewController.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 18/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		let layer = CAGradientLayer()
		layer.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
		layer.colors = [UIColor.red.cgColor, UIColor.black.cgColor]
		view.layer.addSublayer(layer)
    }


}

