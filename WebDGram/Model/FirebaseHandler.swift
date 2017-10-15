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
    
    var db: Firestore
    var storage: Storage
    
    init () {
        self.storage = Storage.storage()
        self.db = Firestore.firestore()
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
        db.collection("posts").getDocuments { (querySnapshot, err) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            var posts: [Post] = []
            
            /* TODO: - Explore custom objects when downloading data
                       https://firebase.google.com/docs/firestore/query-data/get-data?authuser=0
             */
            
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
                let post = Post(username: username, imageRefs: imageRefs, timestamp: Date(), caption: caption, likes: likes, id: document.documentID)
                posts.append(post)
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            completionHandler(posts)
            
            
        }
    }
    
    /*
     Uploads a post to Firebase
     */
    func upload(_ postRequest: PostRequest, completionHandler: @escaping (_ wasSucessful: Bool) -> Void) {
        // Create refernce to new post document
        let newPostRef = db.collection("posts").document()
        
        // Create and store references to all images with an id based on the post document
        // Upload them as the references are made
        var imagePathes = [String]()
        
        // TODO: - Maybe using extensiong upload from memory?
        
        for (index, imageURL) in postRequest.images.enumerated() {
            let fileExtension = imageURL.pathExtension ?? ""
            let ref = storage.reference().child("images/\(newPostRef.documentID)-\(index).\(fileExtension)")
            imagePathes.append(ref.fullPath)
            
            ref.putFile(from: imageURL as URL, metadata: nil) { metadata, err in
                if let err = err {
                    print("Failed to upload image \(imageURL). Error: \(err)")
                    completionHandler(false)
                    return
                }
            }
        }
        newPostRef.setData([
            PostKeys.username : postRequest.username,
            PostKeys.caption : postRequest.caption,
            PostKeys.images : imagePathes,
            PostKeys.likes : 0,
            PostKeys.timestamp: Date()
        ]) { err in
            if let err = err {
                print("Unable to add post to collection. Error \(err)")
                completionHandler(false)
            } else {
                completionHandler(true)
            }
        }
        
        // Call completion
    }
    
    func likePost(with id: String, completionHandler: @escaping () -> Void) {
        //let postRef = firestore.collection("posts").document(id)
        
        // TODO: Save posts a user has liked and prevent multiple likes
        
        
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
