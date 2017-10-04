//
//  PostView.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-09-28.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit

class PostTableCellView: UITableViewCell {
    
    var post: Post = Post() {
        didSet {
            layoutViews()
        }
    }
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let text: String
        if post.images.count <= 1 {
            text = "\(post.username) shared a photo"
        } else {
            text = "\(post.username) shared \(post.images.count) photos"
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
    
    private lazy var imageGalleryView: ImageGalleryView = {
        let gallery = ImageGalleryView()
        gallery.images = post.images
        gallery.translatesAutoresizingMaskIntoConstraints = false
        gallery.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        
        return gallery
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
    private func layoutViews() {
        
        contentView.addSubview(userLabel)
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            userLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
            ])
        
        contentView.addSubview(imageGalleryView)
        NSLayoutConstraint.activate([
            imageGalleryView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 15),
            imageGalleryView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            imageGalleryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageGalleryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        
        contentView.addSubview(captionLabel)
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: imageGalleryView.bottomAnchor, constant: 12),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
            ])
        
        contentView.addSubview(likesLabel)
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 10),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
            ])
    }
    
}
