//
//  ImageSelectionView.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-12.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit

class ImageSelectionView: UIView {

    private let imageHeight = 95
    private let imageWidth = 95
    
    var imageCount = 1
    
    private let scrollView = UIScrollView()
    
    var delegate: ImageSelectionViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Setup scroll view
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        updateContentSize()
        
        // Setup Upload button
        let uploadButton = UIButton(type: .custom)
        uploadButton.frame = CGRect(x: 0, y: 0, width: 95, height: 95)
        uploadButton.setBackgroundImage(#imageLiteral(resourceName: "addImageButton"), for: .normal)
        uploadButton.addTarget(self, action: #selector(uploadButtonDidTouch), for: .touchUpInside)
        scrollView.addSubview(uploadButton)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - User Actions
    @objc private func uploadButtonDidTouch() {
        
        delegate?.userDidTouchAddImageButton()
        
    }
    
    
    // MARK: - Helpers
    func addImageToPreview(_ image: UIImage) {
        let view = UIImageView()
        
        // move by width of all images and margins
        // account for the scrollbars as subviews
        let offset = (imageCount * imageWidth) + (10 * imageCount)
        view.frame = CGRect(x: offset, y: 0, width: imageWidth, height: imageHeight)
        
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        
        view.image = image
        view.contentMode = .scaleAspectFit
        
        scrollView.addSubview(view)
        imageCount += 1
        updateContentSize()
    }

    
    
    func updateContentSize() {
        scrollView.contentSize.width = CGFloat((imageCount * imageWidth) + (imageCount * 10))
    }
    
}





