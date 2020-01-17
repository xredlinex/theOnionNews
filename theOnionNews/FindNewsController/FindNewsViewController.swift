//
//  FindNewsViewController.swift
//  theOnionNews
//
//  Created by alexey sorochan on 14.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit
import Toast_Swift

class FindNewsViewController: UIViewController {
    
    @IBOutlet weak var findNewsTextField: UITextField!
    @IBOutlet weak var deleteFilterButton: UIButton!
    @IBOutlet weak var findNewsButton: UIButton!
    @IBOutlet weak var findNewsView: UIView!
    @IBOutlet weak var selectedDateIntervalTextLabel: UILabel!
    @IBOutlet weak var showFilterHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideDeleteFilterButtonHeightContstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomHeightContstraint: NSLayoutConstraint!
    
    var articles: [Article] = []
    var filterData = ""
    var textForFilterLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findNewsButton.layer.cornerRadius = 12
        findNewsView.layer.cornerRadius = 12
        deleteFilterButton.layer.cornerRadius = 12
        let keyboardhide = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(keyboardhide)
        findNewsTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articles.removeAll()
        findNewsTextField.text = ""
 
        if filterData != "" {
            showFilterHeightConstraint.priority = UILayoutPriority(rawValue: 900)
            hideDeleteFilterButtonHeightContstraint.priority = UILayoutPriority(rawValue: 900)
            selectedDateIntervalTextLabel.text = "\(textForFilterLabel ?? "-")"
        }
    }
    
    @IBAction func didTapSelectDateActionButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DateStoryBoard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SelectDateViewController") as! SelectDateViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapDeleteFilterActionButton(_ sender: Any) {
        textForFilterLabel = ""
        filterData = ""
        showFilterHeightConstraint.priority = UILayoutPriority(rawValue: 600)
        hideDeleteFilterButtonHeightContstraint.priority = UILayoutPriority(rawValue: 600)
    }
    
    @IBAction func didTapFindByKeywordActionButton(_ sender: Any) {
        if let keyword = findNewsTextField.text, keyword != "" {
            if keyword.contains(" ") {
                view.makeToast("поиск только по одному ключевому слову. купите приемиум версию за 9.99$")
            }
            getNews(keyword, filterData)
            debugPrint(filterData)
         } else {
           showErrorAlert("Пустое поле поиска!")
        }
    }
}
