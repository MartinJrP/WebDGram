//
//  HomeTableViewController.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-01.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit
import FirebaseDatabase

class HomeTableViewController: UITableViewController {

    var posts: [Post] = [Post()]
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.register(PostTableCellView.self, forCellReuseIdentifier: "PostCell")
        tableView.estimatedRowHeight = 550.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        setupView()
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
    
    @objc private func presentUploadController() {
        let navController = UINavigationController(rootViewController: UploadViewController())
        present(navController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableCellView else { fatalError() }
        
        cell.post = posts[indexPath.row]
        
        return cell
    }

}
