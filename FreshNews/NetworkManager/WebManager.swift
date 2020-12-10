//
//  WebManager.swift
//  FreshNews
//
//  Created by User on 09.12.2020.
//

import Foundation
class WebManager {
    func downloadPage (url : String, complessionHandler : @escaping(URLRequest)->()) {
        guard let url = URL(string: url) else {return}
        let request = URLRequest(url: url)
        DispatchQueue.global().sync {
            complessionHandler(request)
        }
    }
    func downloadImage (url : String) -> Data? {
        guard let Url = URL(string: url) else {return nil}
        let imageData = try? Data(contentsOf: Url)
        return imageData
    }
}
