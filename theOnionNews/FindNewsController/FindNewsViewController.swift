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
    
    @IBAction func didTapFindByKeywordActionButton(_ sender: Any) {
        if let keyword = findNewsTextField.text, keyword != "" {
            if keyword.contains(" ") {
                let newKeyword = keyword.replacingOccurrences(of: " ", with: "%20")
                downloadNews(newKeyword)
            } else {
                downloadNews(keyword)
            }
         } else {
           showErrorAlert("Пустое поле поиска!")
        }
    }
}
