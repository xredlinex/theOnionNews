//
//  NewsModel.swift
//  theOnionNews
//
//  Created by alexey sorochan on 13.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class NewsSourse: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case status, totalResults, articles
    }
}

class Article: Codable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var articleIsRead: Bool?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content, articleIsRead
    }
}

class Source: Codable {
    var id: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
