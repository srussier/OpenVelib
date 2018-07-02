//
//  FileManager.swift
//  OpenVelib
//
//  Created by Salomé Russier on 30/06/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation


import Foundation

extension FileManager {
    
    public static func documentURL() -> URL? {
        return FileManager.documentURL(childPath: nil)
    }
    
    public static func documentURL(childPath: String?) -> URL? {
        if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            if let path = childPath {
                return documentURL.appendingPathComponent(path)
            }
            return documentURL
        }
        return nil
    }
    
    
}
