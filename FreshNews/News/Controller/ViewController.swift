//
//  ViewController.swift
//  FreshNews
//
//  Created by User on 08.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    var constants = Constants()
    var arrays = Arrays()
    var resixe = UIImage()
    
    
    func frozenStart () {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.constants.timer < 1 {
                self.constants.timer += 1
            } else {
                self.ActivityIndicator.stopAnimating()
                self.ActivityIndicator.isHidden = true
                self.tabBarController?.tabBar.isHidden = false
                self.TableView.isHidden = false
            }
        }
    }
    
    func image(with image: UIImage, scaledTo newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicator.startAnimating()
        TableView.decelerationRate = UIScrollView.DecelerationRate.init(rawValue: 0)
        TableView.isHidden = true
        frozenStart ()
        title = "Fresh News"
        JsonNetworkManager().Article { [self] (modelJson) in
            let new   =  modelJson.articles
            for item in new {
                arrays.content.append(item.source?.name ?? constants.infoEror)
                arrays.author.append(item.author ??  constants.infoEror)
                arrays.titles.append(item.title ??  constants.infoEror)
                arrays.url.append (item.url )
                arrays.urltoImage.append (item.urlToImage ?? constants.erorUrl)
                TableView.reloadData()
            }
        }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrays.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "123", for: indexPath) as! NewsViewCell
        cell.titleLabel.text =  self.arrays.titles[indexPath.row]
        cell.titleLabel.font = cell.titleLabel.font.withSize(12)
        cell.AuthorLabel.text = constants.source + self.arrays.content[indexPath.row]
        cell.AuthorLabel.font = cell.AuthorLabel.font.withSize(12)
        Image().downloadpicture(url: arrays.urltoImage[indexPath.row]) { (dataimage) in
            let imager = UIImage(data: dataimage)
            cell.ImageLabel.image = self.image(with: imager!, scaledTo: CGSize(width: 200, height: 128))
            cell.imageView?.contentMode = .scaleAspectFill
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "Web", sender: nil)
        self.constants.urls = self.arrays.url[indexPath.row]
        self.constants.urlimg = arrays.urltoImage[indexPath.row]
        self.constants.contents = arrays.titles[indexPath.row]
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Web" else {return}
        let WVC = segue.destination as! WebViewController
        DispatchQueue.main.async { [self] in
            WVC.stringurl = constants.urls
            WVC.imageUrl = constants.urlimg
            WVC.content = constants.contents
        }
    }
}
