//
//  ImageNetworkManager.swift
//  FreshNews
//
//  Created by User on 09.12.2020.
//


import Foundation
class Image {
    func downloadpicture (url : String, complessionHandler : @escaping(Data)->()) {
        let queue = DispatchQueue(label: "new", qos: .default, attributes: .concurrent)
        queue.async {
            guard  let url = URL(string: url) else {return}
            guard let  dataimage = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                complessionHandler(dataimage)
            }
        }
    }
}

