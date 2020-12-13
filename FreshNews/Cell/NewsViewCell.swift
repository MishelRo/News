//
//  NewsViewCell.swift
//  FreshNews
//
//  Created by User on 09.12.2020.
//

import UIKit
import SDWebImage
class NewsViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var ImageLabel: UIImageView!
    
    func cellConigure (tableView : UITableView, indexPath : IndexPath, arrays : Arrays, constants : source) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "123", for: indexPath) as! NewsViewCell
        cell.titleLabel.text =  arrays.titles[indexPath.row]
        cell.titleLabel.font = cell.titleLabel.font.withSize(12)
        cell.AuthorLabel.text = " Читать подробнее" + arrays.content[indexPath.row]
        cell.AuthorLabel.font = cell.AuthorLabel.font.withSize(12)
        let currentUrl = arrays.urltoImage[indexPath.row]
        let myimageView = UIImageView()
        myimageView.sd_setImage(with: URL(string: currentUrl), completed: nil)
        cell.ImageLabel.image = myimageView.image
        return cell
    }
    
    func image(with image: UIImage, scaledTo newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
}
