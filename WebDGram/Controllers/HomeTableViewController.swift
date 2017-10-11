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
        tableView.allowsSelection = false
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshPosts(_:)), for: .valueChanged)
        tableView.register(PostTableCellView.self, forCellReuseIdentifier: "PostCell")
        tableView.estimatedRowHeight = 550.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func loadPosts() {
        networkHandler.getAllPosts { posts in
            self.posts = posts
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count != 0 ? 1 : 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableCellView else { fatalError() }
        
        cell.post = posts[indexPath.row]
        
        return cell
    }

    
    // MARK - Actions
    
    @objc private func refreshPosts(_ : UIRefreshControl) {
        loadPosts()
    }
    
    @objc private func presentUploadController() {
        let navController = UINavigationController(rootViewController: UploadViewController())
        present(navController, animated: true, completion: nil)
    }

}
