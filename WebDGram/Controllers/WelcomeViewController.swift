//
//  WelcomeViewController.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-06.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit
import os.log

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        // Setup Logo
        let logoImageView = UIImageView()
        logoImageView.image = #imageLiteral(resourceName: "splash-logo")
        logoImageView.contentMode = .scaleAspectFit
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 152),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62)
        ])
        
        // Setup Message
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to the coolest place to show of the things we make for WEBD!"
        welcomeLabel.numberOfLines = 0
        welcomeLabel.textAlignment = .center
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 64),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22)
        ])
        
        // Setup Button
        let launchButton = UIButton(type: .roundedRect)
        launchButton.setTitle("Get Started", for: .normal)
        launchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        
        
        launchButton.tintColor = .white
        launchButton.layer.cornerRadius = 5
        launchButton.setBackgroundImage(#imageLiteral(resourceName: "buttonBackgroundImage"), for: .normal)
        launchButton.imageView?.contentMode = .scaleToFill
        launchButton.layer.masksToBounds = true
        launchButton.layer.cornerRadius = 5
        
        launchButton.addTarget(self, action: #selector(launchButtonDidTouch), for: .touchUpInside)
        
        launchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(launchButton)
        NSLayoutConstraint.activate([
            launchButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -52),
            launchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            launchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            launchButton.heightAnchor.constraint(equalToConstant: 17 * 3)
        ])
    }
    
    @objc private func launchButtonDidTouch() {
        let storage = AppStorage(isFirstLaunch: false)
        
        let isSucessfulSave = NSKeyedArchiver.archiveRootObject(storage, toFile: AppStorage.SettingsArchiveURL.path)
        if isSucessfulSave {
            os_log("First launch save sucessful", log: .default, type: .debug)
        } else {
            os_log("Failed to save first launch setting", log: .default, type: .error)
        }
        
        dismiss(animated: true, completion: nil)
    }
}





