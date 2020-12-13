//
//  NetworkManager.swift
//  FreshNews
//
//  Created by User on 09.12.2020.
//

import Foundation

struct keys {
    var ApiKey = "5ac4f91d38614945884b10d0bb1adfaa"
    var url =  "http://newsapi.org/v2/top-headlines?language=ru&country=ru&apiKey=5ac4f91d38614945884b10d0bb1adfaa"
    var header = ["cookie": "__cfduid=dad5be2646987286897f874af44f958111607461481"]
}
protocol JsonManagerProtocol {
    func fetchArticle<T : Decodable> (header : [String : String], url : String, closure : @escaping (T?) -> () )
    func decodeJson<T:Decodable> (type : T.Type, from : Data? ) -> T?
}

class JsonNetworkManager : JsonManagerProtocol{
    var key = keys()
    var networkManager = NetworkManager()
    
    func fetchArticle<T : Decodable> (header : [String : String], url : String, closure : @escaping (T?) -> () ) {
        networkManager.getArticles(header: header , url: url) { (responces) in
            guard let data = responces else {return}
            let decode = self.decodeJson(type: T.self, from: data)
            closure(decode)
        } closureEror: { (eror) in
            print (eror as Any)
        }
    }
    
    func decodeJson<T:Decodable> (type : T.Type, from : Data? ) -> T? {
        let decoder = JSONDecoder()
        do {
            guard let data = from  else {return nil}
            let object = try decoder.decode(type.self, from: data)
            return object
        }
        catch {
            print ("eror", error.localizedDescription)
        }
        return nil
    }
}
