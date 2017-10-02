//
//  PostView.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-09-28.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit

class PostView: UIView {
    
    var post = Post()
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let text: String
        if post.photos.count <= 1 {
            text = "\(post.username) shared a photo"
        } else {
            text = "\(post.username) shared \(post.photos.count) photos"
        }
        
        label.text = text
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "xh"
        
        return label
    }()
    
    private lazy var imageView: UIView = {
        let imageView = UIView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        //imageView.image = post.photos[0]
        
        return imageView
    }()
    
    private lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.text = "Just something I had to put together real quick for Greg’s class!"
        
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "x likes"
        
        return label
    }()
    
    
    
    // MARK: - Initializers
    // TODO: Learn how to initialize things lol.
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(userLabel)
        self.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            userLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            userLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
        
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 15),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
        self.addSubview(captionLabel)
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            captionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            captionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
        
        self.addSubview(likesLabel)
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 10),
            likesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
            ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(post: Post) {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.init(frame: frame)
        
        self.post = post
    }
    
}
