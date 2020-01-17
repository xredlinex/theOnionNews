//
//  SelectDateViewController.swift
//  theOnionNews
//
//  Created by alexey sorochan on 16.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit
import Toast_Swift

class SelectDateViewController: UIViewController {
    
    @IBOutlet weak var fromDatePickr: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var setFilterButton: UIButton!
    
    var fromDate = String()
    var toDate = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFilterButton.layer.cornerRadius = 12
        setDateLimit()
    }
    
    @IBAction func fromDatePickerActionPicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: fromDatePickr.date)
        fromDate = date
    }
    
    @IBAction func toDatePickerActionPicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: fromDatePickr.date)
        toDate = date
    }
    @IBAction func didTapApplyDateFilterActionButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindNewsViewController") as! FindNewsViewController
        viewController.textForFilterLabel = "новости с \(fromDate) по \(toDate)"
        viewController.filterData = "&from=\(fromDate)&to=\(toDate)"
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    
    @IBAction func didTapGoBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension SelectDateViewController {
    func setDateLimit() {
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.calendar = calendar
        dateComponents.year = -10
        dateComponents.month = 12
        let limitToDate = calendar.date(byAdding: dateComponents, to: currentDate)
        fromDatePickr.minimumDate = limitToDate
        toDatePicker.minimumDate = limitToDate
        fromDatePickr.maximumDate = currentDate
        toDatePicker.maximumDate = currentDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: fromDatePickr.date)
        fromDate = date
        toDate = date
    }
}
