//
//  ImageGalleryView.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-03.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorageUI

class ImageGalleryView: UIScrollView {

    var imageRefs: [StorageReference]! {
        didSet {
            initialLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("coder\(aDecoder)")
    }
    
    private func initialLayout() {
        guard let images = imageRefs else {
            print("Display image for broken link")
            return
        }
        
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        
        let screenWidth = UIScreen.main.bounds.width
        
        for i in 0..<imageRefs.count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.sd_setImage(with: imageRefs[i], placeholderImage: #imageLiteral(resourceName: "placeholder-loading"))
            let xPos = screenWidth * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: screenWidth, height: screenWidth)
            
            self.addSubview(imageView)
        }
        
        self.contentSize.width = screenWidth * CGFloat(images.count)
    }

}
