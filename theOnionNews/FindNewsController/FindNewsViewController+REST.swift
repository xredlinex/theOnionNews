//
//  FindNewsViewController+REST.swift
//  theOnionNews
//
//  Created by alexey sorochan on 22.01.2020.
//  Copyright © 2020 alexey sorochan. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

extension FindNewsViewController {
    
    func downloadNews(_ keyword: String) {
        view.makeToastActivity(.center)
        let url = URL(string: "https://newsapi.org/v2/everything?q=\(keyword)&pageSize=100&from=2019-12-28&to=2020-01-12")
        if let url = url {
            var urlRequest = URLRequest(url: url)
            urlRequest.allHTTPHeaderFields = ["X-Api-Key" : "439c5ba63c944a2cac581d87e18fc759"]
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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
                        let news = try JSONDecoder().decode(NewsSourse.self, from: jsonData)
                        
                        self.articles = news.articles ?? []
                        DispatchQueue.main.async {
                            if self.articles.count != 0 {
                                for art in self.articles {
                                    art.articleIsRead = false
                                }
                                self.view.hideToastActivity()
                                let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
                                
                                viewController.articles = self.articles
                                self.navigationController?.pushViewController(viewController, animated: true)
                            } else {
                                self.showErrorAlert("Новости на тему \(keyword) - не найдены")
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


extension UIImageView {
    func downloadImage(url: String) {
        let imageUrl = URL(string: url)
        
        if let url = imageUrl {
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if error != nil {
                    print(error ?? "some error")
                    return
                }
                if let image = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: image)
                    }
                }
            }.resume()
        }
    }
}
