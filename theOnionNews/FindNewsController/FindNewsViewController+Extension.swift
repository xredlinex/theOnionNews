//
//  FindNewsViewController+Extension.swift
//  theOnionNews
//
//  Created by alexey sorochan on 14.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit
import Toast_Swift

extension FindNewsViewController {
    @objc func keyboardWillHide() {
        bottomHeightContstraint.constant = 0
        self.view.endEditing(true)
    }
}

extension FindNewsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        bottomHeightContstraint.constant = 50
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case findNewsTextField:
            findNewsTextField.resignFirstResponder()
            bottomHeightContstraint.constant = 0
        default:
            findNewsTextField.resignFirstResponder()
        }
        return true
    }
}

extension FindNewsViewController {
    func showErrorAlert(_ title: String) {
        view.hideToastActivity()
        let alertController = UIAlertController(title: "Что то пошло не так!))", message: title, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
