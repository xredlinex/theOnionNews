//
//  ReadNewsViewController.swift
//  theOnionNews
//
//  Created by alexey sorochan on 15.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit
import WebKit

class ReadNewsViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let recieveURL = URL(string: url) {
            let urlRequest = URLRequest(url: recieveURL)
            webView.load(urlRequest)
        }
        
        
        
        

        
    }
    
    @IBAction func didTapGoBackActionButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
