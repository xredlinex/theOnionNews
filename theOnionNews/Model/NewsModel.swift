//
//  NewsModel.swift
//  theOnionNews
//
//  Created by alexey sorochan on 13.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class NewsSourse {
    var status: String?
    var totalResults: Int?
}

class Source {
    var id: String?
    var name: String?
}

class Article {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var articleIsRead: Bool?
}

