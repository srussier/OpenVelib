//
//  Date+.swift
//  OpenVelib
//
//  Created by Salomé Russier on 01/07/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation


extension Date{

    func toString() -> String!{
        
        let format = DateFormatter()
        format.dateFormat = "HH:mm JJ/MM/YYYY"
        
        return format.string(from: self)
    }
}
