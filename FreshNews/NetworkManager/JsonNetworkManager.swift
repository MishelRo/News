//
//  NetworkManager.swift
//  FreshNews
//
//  Created by User on 09.12.2020.
//

import Foundation
class JsonNetworkManager {
    
    var networkManager = NetworkManager()
    
    func Article ( closure : @escaping (Welcome) -> () ) {
        networkManager.getArticles { (responces) in
            guard let data = responces else {return}
            do {
                let responce = try JSONDecoder().decode(Welcome.self, from: data)
                DispatchQueue.main.async {
                    closure(responce)
                }
            }
            catch {
                print ("eror", error.localizedDescription)
            }
        } closureEror: { (eror) in
            print (eror as Any)
        }
    }
}


