//
//  WebViewController.swift
//  FreshNews
//
//  Created by User on 09.12.2020.
//

import UIKit
import WebKit
class Sources {
    var stringurl = ""
    var imageUrl = ""
    var content = ""
}

class WebViewController: UIViewController {
    
    var sources = Sources()
    
    @IBOutlet weak var WebViews: WKWebView!
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var labelPreview: UILabel!
    @IBOutlet weak var Button: UIButton!
    @IBOutlet weak var ShowAll: UIButton!
    
    @IBAction func Show(_ sender: Any) {
        WebManager().downloadPage(url: sources.stringurl) { [self] (request) in
            self.WebViews.load(request)}
        imagePreview.isHidden = true
        labelPreview.isHidden = true
        ShowAll.isHidden = true
        WebViews.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard  let imagedata = WebManager().downloadImage(url: sources.imageUrl) else {return}
        imagePreview.image = UIImage(data: imagedata)
        labelPreview.text = sources.content
        WebViews.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShowAll.setTitle( " Читать подробней", for: .normal)
    }
}
