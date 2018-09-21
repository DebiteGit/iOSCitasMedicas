//
//  Login2ViewController.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 20/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import UIKit

class Login2ViewController: UIViewController {
	
	// define a variable to store initial touch position
	var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

	@IBAction func swipeDown(_ sender: UIPanGestureRecognizer) {
		let touchPoint = sender.location(in: self.view?.window)
		
		if sender.state == UIGestureRecognizer.State.began {
			initialTouchPoint = touchPoint
		} else if sender.state == UIGestureRecognizer.State.changed {
			if touchPoint.y - initialTouchPoint.y > 0 {
				self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
			}
		} else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
			if touchPoint.y - initialTouchPoint.y > 100 {
				self.dismiss(animated: true, completion: nil)
			} else {
				UIView.animate(withDuration: 0.3, animations: {
					self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
				})
			}
		}
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
