//
//  DataFeatcherService.swift
//  FreshNews
//
//  Created by User on 13.12.2020.
//

import Foundation
class DataFeatcherService {
    var key = keys()
    var jsonNetworkManager : JsonNetworkManager
    init (jsonNetworkManager : JsonNetworkManager = JsonNetworkManager ()) {
        self.jsonNetworkManager = jsonNetworkManager
    }
    
    func fetchArticle (header : [String : String], url : String, closure : @escaping (Welcome?) -> () ) {
        jsonNetworkManager.fetchArticle(header: key.header, url: key.url , closure: closure)
    }
}

