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
    
    @IBOutlet weak var toDatePickr: UIDatePicker!
    
    var selectedDate = 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didTapGoBackButton(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        
        
        navigationController?.pushViewController(viewController, animated: true)
        
        
    }
    
}
