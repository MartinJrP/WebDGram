//
//  Post.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-09-28.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Post {
    let username: String
    let imageRefs: [StorageReference]
    let timestamp: Date
    let caption: String
    let likes: Int
    let id: String
}
