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
    
    @IBAction func didTapFindByKeywordActionButton(_ sender: Any) {
        if let keyword = findNewsTextField.text, keyword != ""{
            getNews(keyword)
        } else {
            debugPrint("empty field")
        }
    }
}

extension FindNewsViewController {
    
    func getNews(_ keyword: String) {
        
        
    }
    
    
}




