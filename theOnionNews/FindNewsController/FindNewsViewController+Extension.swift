//
//  FindNewsViewController+Extension.swift
//  theOnionNews
//
//  Created by alexey sorochan on 14.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import UIKit

extension FindNewsViewController {
    
    func getNews(_ keyword: String) {
        let url = URL(string: "https://newsapi.org/v2/everything?q=\(keyword)&pageSize=100&from=2020-12-28&to=2020-01-12")
        
        if let url = url  {
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = ["X-Api-Key" : "439c5ba63c944a2cac581d87e18fc759"]
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    self.showErrorAlert("error")
                    debugPrint(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        if let httpErrResponse = response as? HTTPURLResponse {
                            if (400...499).contains(httpErrResponse.statusCode) {
                                DispatchQueue.main.async {
                                    self.showErrorAlert("Ошибка Клинета")
                                    debugPrint("Client error: \(httpErrResponse.statusCode)")
                                }
                            }
                            if (500...599).contains(httpErrResponse.statusCode) {
                                DispatchQueue.main.async {
                                    self.showErrorAlert("Ошибка Сервера")
                                    debugPrint("Server error: \(httpErrResponse.statusCode)")
                                }
                            }
                        }
                    }
                    return
                }
                if let jsonData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String : Any]
                        if let jsonArticles = json?["articles"] as? [[String : Any]] {
                            for jsonArticle in jsonArticles {
    
                                let article = Article()
                                let source = Source()
                                if let jsonSourse = jsonArticle["source"] as? [String : Any] {
                                    if let id  = jsonSourse["id"] as? String {
                                        source.id = id
                                    }
                                    if let name = jsonSourse["name"] as? String {
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
                                article.source = source
                                   self.articles.append(article)
                            }
                            DispatchQueue.main.async {
                                if self.articles.count != 0 {
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let viewController = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
                                    viewController.articles = self.articles
                                    self.navigationController?.pushViewController(viewController, animated: true)
                                } else {
                                    self.showErrorAlert("Новости на тему \(keyword) - не найдены")
                                }
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

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

extension FindNewsViewController {
    func showErrorAlert(_ title: String) {
        let alertController = UIAlertController(title: "Что то пошло не так!))", message: title, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}
