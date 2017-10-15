//
//  HomeTableViewController+DataSource.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-12.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import Foundation
import UIKit

extension HomeTableViewController {
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
}
