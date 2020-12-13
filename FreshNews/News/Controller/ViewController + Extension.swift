//
//  ViewControoler + Extension.swift
//  FreshNews
//
//  Created by User on 13.12.2020.
//

import Foundation
import UIKit

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrays.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newcell.cellConigure(tableView: tableView, indexPath: indexPath, arrays: arrays, constants: constants)
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
            WVC.sources.stringurl = constants.urls
            WVC.sources.imageUrl = constants.urlimg
            WVC.sources.content = constants.contents
        }
    }
}
