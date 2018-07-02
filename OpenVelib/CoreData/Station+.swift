//
//  Station.swift
//  OpenVelib
//
//  Created by Salomé Russier on 29/06/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation
import CoreData

extension Station {
    
    public static let shared = Station()
    
    public func getCount() -> Int {
        return Station.shared.getAll().count
    }
    
    public func InsertStation(number:Int, name:String, address:String, status: String, bikeStands:Int, availableBikeStands : Int,availableBikes: Int, lastUpdate: TimeInterval){
        
        if let ctx = DataManager.shared.objectContext{
            
            if let s = NSEntityDescription.insertNewObject(forEntityName: "Station", into: ctx) as? Station{
                
                s.number = Int32(number)
                s.address = address
                s.name = name
                s.status = status
                s.bikeStands = Int32(bikeStands)
                s.availableBikeStands = Int32(availableBikeStands)
                s.availableBike = Int32(availableBikes)
                s.lastUpdate = Date(timeIntervalSince1970: lastUpdate )
            }
            try? ctx.save()
           
        }
    }
    
    public func ModifyStation(number:Int, name:String, address:String, status: String, bikeStands:Int, availableBikeStands : Int,availableBikes: Int, lastUpdate: TimeInterval){
        
        
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "number== \(number)")
        
        if let ctx = DataManager.shared.objectContext{
            if let rows = try? ctx.fetch(fetchRequest) {
                if rows.count > 0 {
                    var currentStation = rows[0]
                    currentStation.status = status
                    currentStation.bikeStands = Int32(bikeStands)
                    currentStation.availableBikeStands = Int32(availableBikeStands)
                    currentStation.availableBike = Int32(availableBikes)
                    currentStation.lastUpdate = Date(timeIntervalSince1970: lastUpdate )
                    try? ctx.save()
                }else{
                    self.InsertStation(number: number, name: name, address: address, status: status, bikeStands: bikeStands, availableBikeStands: availableBikeStands, availableBikes: availableBikes, lastUpdate: lastUpdate)
                }
            }
        }
        
    }
    
    public func getAll() -> [Station] {
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        if let ctx = DataManager.shared.objectContext{
            if let rows = try? ctx.fetch(fetchRequest) {
                return rows
            }
        }
        return [Station]()
    }
    
    
    //debug function
    func deleteAll(){
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        if let ctx = DataManager.shared.objectContext{
            if let rows = try? ctx.fetch(fetchRequest) {
                for row in rows{
                    ctx.delete(row)
                }
                try? ctx.save()
            }
        }
      
    }
    
    
    public func getByStatus(_ status : String) -> [Station]{
        
        if status == "" {
            return Station.shared.getAll()
        }
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "status=='\(status)'")
        if let ctx = DataManager.shared.objectContext{
            if let rows = try? ctx.fetch(fetchRequest) {
                print(rows.count)
                return rows
            }
        }
        return [Station]()
    }
    
    
    public func SearchByStatus(_ status : String, research: String) -> [Station]{
        let stations = getByStatus(status)
        return stations.filter { $0.name!.lowercased().contains(research.lowercased())}
    }
    
    
}
