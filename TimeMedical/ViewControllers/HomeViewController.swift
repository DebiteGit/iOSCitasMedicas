//
//  HomeViewController.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 20/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

	@IBAction func handleLogout(_ sender: UIBarButtonItem) {
		try! Auth.auth().signOut()
		self.dismiss(animated: false, completion: nil)
	}
	
}
