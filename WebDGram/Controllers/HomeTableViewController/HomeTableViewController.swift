//
//  HomeTableViewController.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-01.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit
import Firebase

class HomeTableViewController: UITableViewController {

    var posts: [Post] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var networkHandler: NetworkHandler!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentWelcomeScreenIfFirstLaunch()
       
        setNavigationItem()
        setupView()
        
        networkHandler = NetworkHandler()
        loadPosts()
    }
    
    // MARK: - View Setup
    private func setNavigationItem() {
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(presentUploadController))
        composeButton.tintColor = .black
        navigationItem.rightBarButtonItem = composeButton
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "WebDGram-logo"))
    }
    
    private func setupTableView(){
        tableView.allowsSelection = false
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshPosts(_:)), for: .valueChanged)
        tableView.register(PostTableCellView.self, forCellReuseIdentifier: "PostCell")
        tableView.estimatedRowHeight = 550.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func loadPosts() {
        networkHandler.getAllPosts { posts in
            self.posts = posts
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    fileprivate func presentWelcomeScreenIfFirstLaunch() {
        /*
         If settings file exists, check it to see if this is the first launch. If it is present welcome screen.
         If it doesn't exist show welcome screen.
         */
        if FileManager.default.fileExists(atPath: AppStorage.SettingsArchiveURL.path) {
            let appSettings = NSKeyedUnarchiver.unarchiveObject(withFile: AppStorage.SettingsArchiveURL.path) as? AppStorage
            if let app = appSettings, app.isFirstLaunch {
                present(WelcomeViewController(), animated: true, completion: nil)
            }
        } else {
            present(WelcomeViewController(), animated: true, completion: nil)
        }
    }

    
    // MARK: - Actions
    
    @objc private func refreshPosts(_ : UIRefreshControl) {
        loadPosts()
    }
    
    @objc private func presentUploadController() {
        let navController = UINavigationController(rootViewController: UploadViewController())
        present(navController, animated: true, completion: nil)
    }

}
