//
//  SearchVM.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 30/07/21.
//

import Foundation
import GooglePlaces






class SearchVM {
    var searchStr:String = ""
    var results:[Result] = [] 
     func findPlaces(completion:@escaping(_ err:String?)->Void) {
        let req = ReqData(url: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchStr)&key=\(Constants.apiKey.rawValue)", method: "GET", postData: [:], Headers: ["Content-Type": "application/json"])
        ServiceHandler.executeService(expection: PlacesBaseModel.self, req: req) {(result) in
            switch result{
            case .success(let res):
                if res.status == "OK"{
                    self.results = res.results
                    completion(nil)
                }else if res.status == "REQUEST_DENIED"{
                    if let data = self.loadStaticData(){
                        let res = try? JSONDecoder().decode(PlacesBaseModel.self, from: data)
                        self.results = res?.results ?? []
                        completion(nil)
                    }
                }else{
                    completion(HandleError.NullRes.localizedDescription)
                }
                
            case .failure(.NullRes):
            completion(HandleError.NullRes.localizedDescription)
                
            }
        }
        
    }
    
     func loadStaticData()->Data? {
        if let url = Bundle.main.url(forResource: "staticData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                return data
              } catch {
                   // handle error
              }
        }
        return nil
    }
    

}
