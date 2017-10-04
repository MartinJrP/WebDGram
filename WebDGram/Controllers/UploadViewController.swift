//
//  UploadViewController.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-04.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        navigationItem.rightBarButtonItem = cancelButton

    }
    
    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
}
