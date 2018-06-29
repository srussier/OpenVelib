//
//  Station.swift
//  OpenVelib
//
//  Created by Salomé Russier on 29/06/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation

class Station {
    
    //TODO change Date 
    
    var number : Int
    var name : String
    var adresse : String
    var status : String
    var bikeStands : Int
    var availableBikeStands : Int
    var availableBike: Int
    var lastUpdate: Date
    
    init(number:Int, name:String, adresse:String, status: String, bikeStands:Int, availableBikeStands : Int,availableBike: Int) {
        self.number = number
        self.name = name
        self.adresse = adresse
        self.status = status
        self.bikeStands = bikeStands
        self.availableBikeStands = availableBikeStands
        self.availableBike = availableBike
        self.lastUpdate = Date()
    }
 
    
  
    
    
    
    
    
    
}
