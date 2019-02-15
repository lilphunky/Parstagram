//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Lily Pham on 2/14/19.
//  Copyright © 2019 Lily Pham. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error signing up: \(error?.localizedDescription)")
            }
        }
    }
    
   
    @IBAction func onLogIn(_ sender: Any) {
    }
    
}
