//
//  APIController.swift
//  OpenVelib
//
//  Created by Salomé Russier on 29/06/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation

class APIController {

    let uri = "https://api.jcdecaux.com/vls/v1"
    let route_station = "/stations?contract=Nantes"
    let token = "&apiKey=0e901b8c5c17841c6549066aebdbb854c62111f8"
    
    func getStation() ->[Station]{
        //TODO : change it's tricky
        var result : [Station] = []
        
        let requestURL: URL = URL(string: uri + route_station + token)!
        let urlRequest: URLRequest = URLRequest(url: requestURL)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                if let json = try? JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! Array<Dictionary<String, Any>>{
                    
                    for item in json {
                        let station = Station(number : (item["number"] as? Int)!,
                                              name: (item["name"] as? String)!,
                                              adresse: (item["adresse"] as? String)!,
                                              status: (item["status"] as? String)!,
                                              bikeStands: (item["bikeStands"]!as? Int)!,
                                              availableBikeStands: (item["availableBikeStands"]!as? Int)!,
                                              availableBike: (item["availableBike"]as? Int)!
                        )
                        result.append(station)
                    }
                }
            }
        })
        task.resume()
        
        return result
        
    }
    

}

