//
//  NewsTableViewCell.swift
//  theOnionNews
//
//  Created by alexey sorochan on 14.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articlePublishedAtTextLabel: UILabel!
    @IBOutlet weak var authorTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension NewsTableViewCell {
    func updateNewsCell(_ article: Article) {
        titleTextLabel.text = article.title ?? "no title"
        descriptionTextLabel.text = article.description ?? "no desciption"
        articleImageView.downloadImage(url: article.urlToImage ?? "noImage")
        articlePublishedAtTextLabel.text = article.publishedAt ?? "00-00-00"
        authorTextLabel.text = article.author ?? "-"
    }
}
