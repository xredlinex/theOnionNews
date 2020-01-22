//
//  ReadNewsViewController.swift
//  theOnionNews
//
//  Created by alexey sorochan on 15.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit
import WebKit
import Toast_Swift

class ReadNewsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var url = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        if let recieveURL = URL(string: url) {
            let urlRequest = URLRequest(url: recieveURL)
            webView.load(urlRequest)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            debugPrint("loading page")
            debugPrint(Float(webView.estimatedProgress))
            self.view.makeToastActivity(.center)
        }
        if webView.estimatedProgress == 1.0 {
            self.view.hideToastActivity()
            debugPrint("stop loading page")
        }
    }
    
    @IBAction func didTapGoBackActionButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
