//
//  ArticlesViewController.swift
//  UppermostNews
//
//  Created by Cris on 12/4/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

private let reuseIdentifier = "articleDescriptionCell"


class ArticlesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var articlesTableView: UITableView!
    
    
    var articleDetails: NewsSources!
    var articles: [SourceArticles] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTableView.rowHeight = UITableViewAutomaticDimension
        articlesTableView.estimatedRowHeight = 200
        loadDelegates()
        loadDetails()
        APICall()
//        self.navigationController
        // Do any additional setup after loading the view.
    }
    
    func APICall() {
        let sourceID = articleDetails.sourceID
        dump(sourceID)
        let url = "https://newsapi.org/v1/articles?source=\(sourceID)&apiKey=df4c5752e0f5490490473486e24881ef"
        APIManager.shared.getData(urlString: url){ (data: Data?) in
            if let validData = data,
                let parsedArticles = SourceArticles.parseArticles(from: validData) {
                self.articles = parsedArticles
                DispatchQueue.main.async {
                    self.articlesTableView.reloadData()
                }
            }
        }
    }
    
    func loadDelegates() {
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
    }
    
    func loadDetails() {
        textLabel.text = articleDetails.sourceName
        GetImage.shared.getImage(urlString: articleDetails.sourceLogo) { (image: UIImage?) in
            if let logoImage = image {
                self.logoImageView.image = logoImage
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articlesTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let cells = cell as? ArticlesTableViewCell {
            
            let article = articles[indexPath.row]
            cells.titleLabel.text = article.title
            cells.descriptionLabel.text = article.publishedDate
        }
        return cell
    }
    
    
}
