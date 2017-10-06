//
//  FirebaseHandler.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-04.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import Foundation
import Firebase

class NetworkHandler {
    
    var firestore: Firestore
    var storage: Storage
    
    init () {
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
    }
    
    // Error handling only used for FailedToUnwrapImage
    enum FirebaseError: Error {
        case FailedToUnwrapImage
        case DocumentUnavailable
    }
    
    
    /*
     Get all posts from the database and passes a collection of ready to use post to a completion handler
    */
    func getAllPosts(completionHandler: @escaping ([Post]) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        firestore.collection("posts").getDocuments { (querySnapshot, err) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            var posts: [Post] = []
            
            for document in querySnapshot!.documents {
                
                let postData = document.data()
                
                guard
                    let username = postData["username"] as? String,
                    //let timestamp = postData["timestamp"] as? String,
                    let imagePathes = postData["images"] as? NSArray,
                    let caption = postData["caption"] as? String,
                    let likes = postData["likes"] as? Int
                    else {
                        print("Error extracting data from database")
                        return
                }
                
                // process image refs
                let imageRefs = try! self.getImageRefs(from: imagePathes)
                
                // set date
                // to do...
                
                // make post
                let post = Post(username: username, imageRefs: imageRefs, timestamp: Date(), caption: caption, likes: likes)
                posts.append(post)
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            completionHandler(posts)
            
            
        }
    }
    

    
    
    private func getImageRefs(from imagePathes: NSArray) throws -> [StorageReference] {
        var imageRefs: [StorageReference] = []
        
        for path in imagePathes {
            guard let path = path as? String else {
                print("Error getting image")
                throw FirebaseError.FailedToUnwrapImage
            }
            
            imageRefs.append(self.storage.reference(withPath: path))
        }
        
        return imageRefs
    }
    
}
