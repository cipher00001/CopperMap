//
//  ServiceHandler.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 01/08/21.
//

import Foundation

enum HandleError:Error {
    case NullRes
}


struct ReqData {
    var url:String = ""
    var method:String?
    var postData:[String:Any]?
    var Headers:[String:Any] = ["Content-Type": "application/json"]
}

struct ServiceHandler {
   static func executeService<T:Decodable>(expection: T.Type,req :ReqData , completion:@escaping(Swift.Result<T,HandleError>)->Void) {
        URLSession.shared.dataTask(with: URL.init(string: req.url)!){(data,response,err) in
            if err != nil{
                completion(.failure(.NullRes))
            }
            if let responsedata = data{
                let res = try? JSONDecoder().decode(expection, from: responsedata)
                if let res = res{
                    completion(.success(res))
                }else{
                    completion(.failure(.NullRes))
                }
            }
        }.resume()
        
    }
}
