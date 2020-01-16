//
//  NewsViewController+Extension.swift
//  theOnionNews
//
//  Created by alexey sorochan on 16.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

extension NewsViewController {
    func makeUIElementh() {
        tableView.separatorColor = UIColor(displayP3Red: 0/255, green: 115/255, blue: 84/255, alpha: 1)
        newsCountTextLabel.clipsToBounds = true
        newsCountTextLabel.layer.cornerRadius = newsCountTextLabel.frame.width / 2
        newsCountTextLabel.layer.borderColor = UIColor.white.cgColor
        newsCountTextLabel.layer.borderWidth = 2
    }
}

