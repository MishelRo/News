//
//  ViewController.swift
//  FreshNews
//
//  Created by User on 08.12.2020.
//

import UIKit
import SDWebImage

struct source {
    var urls = ""
    var stringurl = ""
    var imageUrl = ""
    var content = ""
    var urlimg = ""
    var contents = ""
}

class ViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    var jsonmanager = JsonNetworkManager()
    var datafetcher = DataFeatcherService()
    var constants = source()
    var arrays = Arrays()
    var resize = UIImage()
    var newcell = NewsViewCell()
    var key = keys()
    var article : [Article]!
    
    func frozenStart () {
        var timer = 0.0
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            if timer < 1 {timer += 1 } else {
                self.ActivityIndicator.stopAnimating()
                self.ActivityIndicator.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
                self.TableView.isHidden = false }
            TableView.reloadData()
        }
    }
    
    func getarticles () {
        datafetcher.fetchArticle(header: key.header, url: key.url) {[self] (modelJson) in
            let new   =  modelJson!.articles
            DispatchQueue.main.async {
                for item in new {
                    article = new
                    arrays.content.append(item.source?.name ?? "информация не доступна")
                    arrays.author.append(item.author ?? "информация не доступна")
                    arrays.titles.append(item.title ??  "информация не доступна")
                    arrays.url.append (item.url )
                    arrays.urltoImage.append (item.urlToImage ?? "https://avatars.mds.yandex.net/get-pdb/911433/5bc8852a-315d-48e7-a6c4-3fc3db2aabad/s1200?webp=false")
                    TableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getarticles ()
        ActivityIndicator.startAnimating()
        TableView.decelerationRate = UIScrollView.DecelerationRate.init(rawValue: 0)
        TableView.isHidden = true
        frozenStart ()
        title = "Fresh News"
        
    }
}


