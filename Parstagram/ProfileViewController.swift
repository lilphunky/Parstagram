//
//  ProfileViewController.swift
//  Parstagram
//
//  Created by Lily Pham on 2/26/19.
//  Copyright © 2019 Lily Pham. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePicImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()!
        usernameLabel.text = user.username
        
        if user["profilePic"] != nil {
            let imageFile = user["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            profilePicImageView.af_setImage(withURL: url)
        }
    }
    
    @IBAction func onChooseProfilePicButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // If camera available, use camera, else use the photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 190, height: 190)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        profilePicImageView.image = scaledImage
        
        let imageData = scaledImage.pngData()
        let file = PFFileObject(data: imageData!)
        let user = PFUser.current()!
        user["profilePic"] = file
        
        user.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Profile picture saved!")
            } else {
                print("Error saving profile picture")
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
