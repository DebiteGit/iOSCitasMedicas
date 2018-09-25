//
//  HomeViewController.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 20/09/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import UIKit
import FirebaseAuth
import JTAppleCalendar

class HomeViewController: UIViewController {
	
	let outsideMonthColor = UIColor.lightGray
	let monthColor = UIColor.black
	let selectedMonthColor = UIColor.white
	let currentDateSelectedViewColor = UIColor.darkGray
	
	let formatter = DateFormatter()

	@IBOutlet weak var calendarView: JTAppleCalendarView!
	@IBOutlet weak var yearMonth: UINavigationItem!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		setupCalendarView()
    }
	
	func setupCalendarView() {
		// Setup calendar spacing
		calendarView.minimumLineSpacing = 0
		calendarView.minimumInteritemSpacing = 0
		
		// Setup labels
		calendarView.visibleDates{ visibleDates in
			self.setupViwesOfCalendar(from: visibleDates)
		}
	}
	
	func handleCellTextcolor(view: JTAppleCell?, cellState:CellState) {
		guard let validCell = view as? CustomCell else {return}
		
		if cellState.isSelected {
			validCell.dateLabel.textColor = selectedMonthColor
		}else{
			validCell.dateLabel.textColor = (cellState.dateBelongsTo == .thisMonth ? monthColor : outsideMonthColor)
		}
	}
	
	func handleCellSelected(view: JTAppleCell?, cellState:CellState) {
		guard let validCell = view as? CustomCell else {return}
		validCell.selectedView.isHidden = (cellState.isSelected ? false : true)
	}
	
	func setupViwesOfCalendar(from visibleDates: DateSegmentInfo) {
		let date = visibleDates.monthDates.first!.date
		
		formatter.dateFormat = "yyyy"
		let year = formatter.string(from: date)
		formatter.dateFormat = "MMMM"
		let month = formatter.string(from: date)
		
		yearMonth.title = month.capitalized + " " + year
	}
    
	@IBAction func handleLogout(_ sender: UIBarButtonItem) {
		try! Auth.auth().signOut()
		self.dismiss(animated: true, completion: nil)
	}
	
}

