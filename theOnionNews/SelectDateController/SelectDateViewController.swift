//
//  SelectDateViewController.swift
//  theOnionNews
//
//  Created by alexey sorochan on 16.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    @IBOutlet weak var fromDatePickr: UIDatePicker!
    
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    @IBOutlet weak var setFilterButton: UIButton!
    
    var fromDate: String?
    var toDate: String?
    var selectedFilter: String?
    

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
    
    
    @IBAction func didTapGoBackButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindNewsViewController") as! FindNewsViewController
        
        
        navigationController?.pushViewController(viewController, animated: false)
        
        
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
    }
}
