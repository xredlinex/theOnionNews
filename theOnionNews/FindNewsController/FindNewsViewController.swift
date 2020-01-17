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
    @IBOutlet weak var bottomHeightContstraint: NSLayoutConstraint!
    @IBOutlet weak var findNewsButton: UIButton!
    @IBOutlet weak var findNewsView: UIView!
    
    var articles: [Article] = []
    var fromDate: String?
    var toDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findNewsButton.layer.cornerRadius = 12
        findNewsView.layer.cornerRadius = 12
        let keyboardhide = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(keyboardhide)
        findNewsTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articles.removeAll()
        findNewsTextField.text = ""
    }
    
    @IBAction func didTapSelectDateActionButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DateStoryBoard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SelectDateViewController") as! SelectDateViewController
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func didTapFindByKeywordActionButton(_ sender: Any) {
        if let keyword = findNewsTextField.text, keyword != "" {
            if keyword.contains(" ") {
                view.makeToast("поиск только по одному ключевому слову. купите приемиум версию за 9.99$")
            }
            getNews(keyword)
         } else {
           showErrorAlert("Пустое поле поиска!")
        }
    }
}
