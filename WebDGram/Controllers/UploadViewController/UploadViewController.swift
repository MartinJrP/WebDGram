//
//  UploadViewController.swift
//  WebDGram
//
//  Created by Martin Jr Powlette on 2017-10-04.
//  Copyright © 2017 Martin Jr Powlette. All rights reserved.
//

import UIKit
import Photos

class UploadViewController: UIViewController, ImageSelectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let scrollView = UIScrollView()
    let imageSelector = ImageSelectionView()
    let imagePicker = UIImagePickerController()
    
    var selectedImages = [NSURL]()
    let usernameField = UITextField()
    let captionField = UITextField()
    
    
    // MARK: - Load View
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setNavigationItem()
        setScrollView()
        setupSubviews()

    }
    
    // MARK: - View Setup
    
    fileprivate func setNavigationItem() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissController))
        navigationItem.leftBarButtonItem = cancelButton
        
        let uploadButton = UIBarButtonItem(title: "Upload", style: .done, target: self, action: #selector(uploadPost))
        navigationItem.rightBarButtonItem = uploadButton
    }
    
    fileprivate func setScrollView() {
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    private func setupSubviews() {
        // Images Label
        let imageLabel = UILabel()
        imageLabel.text = "Your Swanky Candids"
        view.addSubview(imageLabel)
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            imageLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
        
        // Image Selection View
        // Started using hard values because auto layout is problematic with scrollviews?
        // TODO: Make height here derived from one value
        imageSelector.delegate = self
        
        view.addSubview(imageSelector)
        imageSelector.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageSelector.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 7),
            imageSelector.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageSelector.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageSelector.heightAnchor.constraint(equalToConstant: 95)
            ])
        
        // Username Label
        let usernameLabel = UILabel()
        usernameLabel.text = "Your First Name"
        
        view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: imageSelector.bottomAnchor, constant: 40),
            usernameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
        
        // Label Text Field
        usernameField.placeholder = "A sweet username to rule them all"
        view.addSubview(usernameField)
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2),
            usernameField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            usernameField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
        
        // Caption Label
        let captionLabel = UILabel()
        captionLabel.text = "A kick-ass description"
        view.addSubview(captionLabel)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 40),
            captionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
        
        // Caption Field
        captionField.placeholder = "Tell us why this is super cool"
        view.addSubview(captionField)
        captionField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            captionField.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 2),
            captionField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            captionField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])
    }
    
    
    // MARK: - Actions
    
    @objc private func dismissController() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func uploadPost() {
        // Set spinner to right navigation item
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        let uploadBarButtonItem = navigationItem.rightBarButtonItem
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        navigationItem.rightBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        
        let postRequest = PostRequest(username: usernameField.text!, images: selectedImages, caption: captionField.text!)
        
        let networkHandler = NetworkHandler()
        networkHandler.upload(postRequest) { wasSucessful in
            if wasSucessful {
                self.dismissController()
            } else {
                let alert = UIAlertController(title: "Failed To Upload Post", message: "Something went wrong and we're not 100% sure what it was. Maybe try again in a bit?", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                self.navigationItem.rightBarButtonItem = uploadBarButtonItem
                alert.addAction(okButton)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    // MARK: - ImageSelectorDelegate Methods
    
    func userDidTouchAddImageButton() {
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
              let imageURL = info[UIImagePickerControllerImageURL] as? NSURL
        else { return }
        
        selectedImages.append(imageURL)
        imageSelector.addImageToPreview(image)
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
