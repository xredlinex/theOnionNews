//
//  NewsViewController.swift
//  theOnionNews
//
//  Created by alexey sorochan on 14.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

 
    @IBOutlet weak var tableView: UITableView!
    
    var articles: [Article] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getNews()
        
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
   
      
       
    }
}


extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.updateNewsCell(articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


extension NewsViewController {
    
    func getNews() {
        let url = URL(string: "https://newsapi.org/v2/everything?q=Bitcoin")
        
        if let url = url {
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = ["X-Api-Key" : "439c5ba63c944a2cac581d87e18fc759"]
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest) { (data, responce, error) in
                if let jsonData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String : Any]
                        if let jsonArticles = json?["articles"] as? [[String : Any]] {
                            for jsonArticle in jsonArticles {
                                let article = Article()
                                let source = Source()
                                if let jsonSource = jsonArticle["source"] as? [String : Any] {
                                    if let id = jsonSource["id"] as? String {
                                        source.id = id
                                    }
                                    if let name = jsonSource["name"] as? String {
                                        source.name = name
                                    }
                                }
                                if let author = jsonArticle["author"] as? String {
                                    article.author = author
                                }
                                if let title = jsonArticle["title"] as? String {
                                    article.title = title
                                }
                                if let description = jsonArticle["description"] as? String {
                                    article.description = description
                                }
                                if let url = jsonArticle["url"] as? String {
                                    article.url = url
                                }
                                if let urlToImage = jsonArticle["urlToImage"] as? String {
                                    article.urlToImage = urlToImage
                                }
                                if let publishedAt = jsonArticle["publishedAt"] as? String {
                                    article.publishedAt = publishedAt
                                }
                                if let content = jsonArticle["content"] as? String {
                                    article.content = content
                                }
                                self.articles.append(article)
                            }
                            for art in self.articles {
                                debugPrint(art.content)
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    } catch {
                        debugPrint(error)
                    }
                }
            } .resume()
            
        }
    }
}

