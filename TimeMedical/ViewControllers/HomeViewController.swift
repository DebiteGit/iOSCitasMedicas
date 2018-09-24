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
import JTAppleCalendar

class HomeViewController: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
	
	let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
	@IBAction func handleLogout(_ sender: UIBarButtonItem) {
		try! Auth.auth().signOut()
		self.dismiss(animated: true, completion: nil)
	}
	
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
		print("CalendarView")
	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
		cell.dateLabel.text = cellState.text
		return cell
	}
	
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		print("Formatear Calendario")
		
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		formatter.locale = Calendar.current.locale
		
		let startDate = formatter.date(from: "2018 09 01")!
		let endDate = formatter.date(from: "2018 12 31")!
		
		let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
		return parameters
	}
	
}
