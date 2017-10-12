//
//  Storage.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-12.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import Foundation
import os.log

class AppStorage: NSObject, NSCoding {
    
    var isFirstLaunch: Bool
    
    init(isFirstLaunch: Bool) {
        self.isFirstLaunch = isFirstLaunch
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let isFirstLaunch = aDecoder.decodeBool(forKey: PropertyKey.isFirstLaunch)
        
        self.init(isFirstLaunch: isFirstLaunch)
    }
    
    //MARK: - Archiving Paths
    
    static let ApplicationSupportDirectory = FileManager().urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    static let SettingsArchiveURL = ApplicationSupportDirectory.appendingPathComponent("settings")
    
    // MARK: - NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(isFirstLaunch, forKey: PropertyKey.isFirstLaunch)
    }
    
}

// MARK - Keys
struct PropertyKey {
    static let isFirstLaunch = "isFirstLaunch"
}
