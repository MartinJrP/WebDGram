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
    let images: [UIImage]
    let timestamp: Date
    let caption: String
    let likes: Int
    
    init(){
        self.username = "skydrew15"
        self.images = [#imageLiteral(resourceName: "dog1"), #imageLiteral(resourceName: "dog2"), #imageLiteral(resourceName: "dog3")]
        self.timestamp = Date()
        self.caption = "A description"
        self.likes = 5
    }
}
