//
//  FindNewsViewController+Extension.swift
//  theOnionNews
//
//  Created by alexey sorochan on 14.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

extension FindNewsViewController {
    @objc func keyboardWillHide() {
        bottomHeightContstraint.constant = 0
        self.view.endEditing(true)
    }
}

extension FindNewsViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        bottomHeightContstraint.constant = 250
        return true
    }
}
