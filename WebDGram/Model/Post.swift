//
//  Post.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-09-28.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import Foundation
import UIKit

struct Post {
    let username: String
    let photos: [UIImage]
    let timestamp: Date
    let description: String
    let likes: Int
    
    
    init(username: String, photos: [UIImage], timestamp: Date, description: String, likes: Int){
        self.username = username
        self.photos = photos
        self.timestamp = timestamp
        self.description = description
        self.likes = likes
    }
    
    init(){
        self.username = "skydrew"
        self.photos = [UIImage()]
        self.timestamp = Date()
        self.description = "A description"
        self.likes = 5
    }
}
