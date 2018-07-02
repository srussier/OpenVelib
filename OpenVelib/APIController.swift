//
//  APIController.swift
//  OpenVelib
//
//  Created by Salomé Russier on 29/06/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation
import SystemConfiguration

class APIController {
    
    // public static let shared = APIController()
    
    let uri = "https://api.jcdecaux.com/vls/v1"
    let route_station = "/stations?contract=Nantes"
    let token = "&apiKey=0e901b8c5c17841c6549066aebdbb854c62111f8"
    
    func getStation(_ group: DispatchGroup){
        let requestURL: URL = URL(string: uri + route_station + token)!
        let urlRequest: URLRequest = URLRequest(url: requestURL)
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) -> Void in
            
            
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String, Any>>{
                    for item in json {
                        Station.shared.ModifyStation(number : (item["number"] as? Int)!,
                                                     name: (item["name"] as? String)!,
                                                     address: (item["address"] as? String)!,
                                                     status: (item["status"] as? String)!,
                                                     bikeStands: (item["bike_stands"]!as? Int)!,
                                                     availableBikeStands: (item["available_bike_stands"]!as? Int)!,
                                                     availableBikes: (item["available_bikes"]as? Int)!,
                                                     lastUpdate: (TimeInterval((item["last_update"] as? Double)!))
                        )
                    }
                    group.leave()
                }
            }
        })
        task.resume()
        
    }
    
    
    func internetAcces() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
        
        
    }
    
    
}

