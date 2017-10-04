//
//  ImageGalleryView.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-03.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit

class ImageGalleryView: UIScrollView {

    var images: [UIImage]? {
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
        guard let images = images else {
            print("Display image for broken link")
            return
        }
        
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
        
        let screenWidth = UIScreen.main.bounds.width
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFill
            
            let xPos = screenWidth * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0, width: screenWidth, height: screenWidth)
            
            self.addSubview(imageView)
        }
        
        self.contentSize.width = screenWidth * CGFloat(images.count)
    }

}
