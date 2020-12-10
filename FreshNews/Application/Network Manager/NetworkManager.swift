//
//  NetworkManager.swift
//  FreshNews
//
//  Created by User on 08.12.2020.
import Foundation
class NetworkManager {
    var ApiKey = "5ac4f91d38614945884b10d0bb1adfaa"
    var url = URL(string: "http://newsapi.org/v2/everything?q=Apple&from=2020-12-08&sortBy=popularity&apiKey=5ac4f91d38614945884b10d0bb1adfaa")
    func getArticles (clousureResponce : @escaping (Data?) -> (), closureEror : @escaping (Error?) -> () ) {
        let headers = ["cookie": "__cfduid=dad5be2646987286897f874af44f958111607461481"]
        let postData = NSData(data: "".data(using: String.Encoding.utf8)!)
        let request = NSMutableURLRequest(url: NSURL(string: "http://newsapi.org/v2/top-headlines?language=ru&country=ru&apiKey=5ac4f91d38614945884b10d0bb1adfaa")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                closureEror(error)
            } else {
                clousureResponce(data)
            }
        })
        dataTask.resume()
    }
}


//https://newsapi.org/v1/articles?source=bbc-news&sortBy=top&apiKey=4dbc17e007ab436fb66416009dfb59a8
//"http://newsapi.org/v2/everything?q=Apple&from=2020-12-08&sortBy=popularity&apiKey=5ac4f91d38614945884b10d0bb1adfaa" my
