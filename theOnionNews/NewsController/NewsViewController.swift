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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUIElementh()
        newsCountTextLabel.text = "\(articles.count)"
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ReedNewsViewController") as! ReedNewsViewController
        viewController.url = articles[indexPath.row].url ?? "apple.com"
        navigationController?.pushViewController(viewController, animated: true)
        return
    }
    
}

extension NewsViewController {
    func makeUIElementh() {
        newsCountTextLabel.clipsToBounds = true
        newsCountTextLabel.layer.cornerRadius = newsCountTextLabel.frame.width / 2
        newsCountTextLabel.layer.borderColor = UIColor.white.cgColor
        newsCountTextLabel.layer.borderWidth = 2
    }
}
