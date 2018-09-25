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
	
	override func viewDidLoad() {
        super.viewDidLoad()
		setupCalendarView()
    }
	
	func setupCalendarView() {
		calendarView.minimumLineSpacing = 0
		calendarView.minimumInteritemSpacing = 0
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
    
	@IBAction func handleLogout(_ sender: UIBarButtonItem) {
		try! Auth.auth().signOut()
		self.dismiss(animated: true, completion: nil)
	}
	
}

