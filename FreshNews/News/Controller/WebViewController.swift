//
//  WebViewController.swift
//  FreshNews
//
//  Created by User on 09.12.2020.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    
    var constants = Constants()
    var stringurl = ""
    var imageUrl = ""
    var content = ""
   
    @IBOutlet weak var WebViews: WKWebView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var labelPreview: UILabel!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var ShowAll: UIButton!
    
    
    @IBAction func Show(_ sender: Any) {
        WebManager().downloadPage(url: self.stringurl) { [self] (request) in
            self.WebViews.load(request)
        }
        imagePreview.isHidden = true
        labelPreview.isHidden = true
        ShowAll.isHidden = true
        WebViews.isHidden = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard  let imagedata = WebManager().downloadImage(url: imageUrl) else {return}
        imagePreview.image = UIImage(data: imagedata)
        labelPreview.text = content
        WebViews.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowAll.setTitle( constants.readMore, for: .normal)
        
        
    }
}
