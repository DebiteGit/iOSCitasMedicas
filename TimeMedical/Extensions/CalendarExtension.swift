//
//  CalendarExtension.swift
//  TimeMedical
//
//  Created by Carlos Espinoza on 9/24/18.
//  Copyright © 2018 Carlos Espinoza. All rights reserved.
//

import Foundation
import JTAppleCalendar

extension HomeViewController: JTAppleCalendarViewDataSource{
	func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
		formatter.dateFormat = "yyyy MM dd"
		formatter.timeZone = Calendar.current.timeZone
		formatter.locale = Calendar.current.locale
		
		let startDate = formatter.date(from: "2018 09 01")!
		let endDate = formatter.date(from: "2018 12 31")!
		
		let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
		return parameters
	}
}

extension HomeViewController: JTAppleCalendarViewDelegate {
	func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
		print("Ya se armó")
	}
	
	func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
		let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
		cell.dateLabel.text = cellState.text
		
		handleCellSelected(view: cell, cellState: cellState)
		handleCellTextcolor(view: cell, cellState: cellState)

		return cell
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		handleCellSelected(view: cell, cellState: cellState)
		handleCellTextcolor(view: cell, cellState: cellState)
	}
	
	func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
		handleCellSelected(view: cell, cellState: cellState)
		handleCellTextcolor(view: cell, cellState: cellState)
	}
}
