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
    @IBOutlet weak var newsCountTextLabel: UILabel!
    
    var articles: [Article] = []
    var unreadArticles = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUIElementh()
        
//        for artcle in articles {
//            if artcle.articleIsRead == false {
//                unreadArticles += 1
//            }
//        }
        unreadArticles = articles.count
        
        newsCountTextLabel.text = "\(unreadArticles)"
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.reloadData()
    }

    
    @IBAction func didTapGoBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: false)
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ReadNewsViewController") as! ReadNewsViewController
        viewController.url = articles[indexPath.row].url ?? "apple.com"
        navigationController?.pushViewController(viewController, animated: true)
        return
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if articles[indexPath.row].articleIsRead == false {
            articles[indexPath.row].articleIsRead = true
            unreadArticles -= 1
            newsCountTextLabel.text = "\(unreadArticles)"
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: -10, width: tableView.frame.width, height: 40))
        let label = UILabel(frame: view.frame)
            
        label.text = "найдено \(articles.count) новостей"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(displayP3Red: 0/255, green: 115/255, blue: 84/255, alpha: 1).cgColor
        label.font = label.font.withSize(10)
        view.addSubview(label)
        return view
    }
    
}

extension NewsViewController {
    func makeUIElementh() {
        tableView.separatorColor = UIColor(displayP3Red: 0/255, green: 115/255, blue: 84/255, alpha: 1)
        newsCountTextLabel.clipsToBounds = true
        newsCountTextLabel.layer.cornerRadius = newsCountTextLabel.frame.width / 2
        newsCountTextLabel.layer.borderColor = UIColor.white.cgColor
        newsCountTextLabel.layer.borderWidth = 2
    }
}
