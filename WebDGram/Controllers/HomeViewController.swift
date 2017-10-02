//
//  ViewController.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-09-28.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setNavigationItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let postView = PostView(post: Post())
        postView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(postView)
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            postView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    
    // MARK - View Setup
    private func setNavigationItem() {
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: nil, action: nil)
        composeButton.tintColor = .black
        navigationItem.rightBarButtonItem = composeButton
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "WebDGram-logo"))
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}

