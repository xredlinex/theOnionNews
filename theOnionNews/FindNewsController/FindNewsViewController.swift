//
//  FindNewsViewController.swift
//  theOnionNews
//
//  Created by alexey sorochan on 14.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class FindNewsViewController: UIViewController {
    
    @IBOutlet weak var findNewsTextField: UITextField!
    @IBOutlet weak var bottomHeightContstraint: NSLayoutConstraint!
    
    var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findNewsTextField.delegate = self
        let keyboardhide = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(keyboardhide)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articles.removeAll()
        findNewsTextField.text = ""
    }
    
    @IBAction func didTapFindByKeywordActionButton(_ sender: Any) {
        if let keyword = findNewsTextField.text, keyword != "" {
            getNews(keyword)
         } else {
           showErrorAlert("Пустое поле поиска!")
        }
    }
}

