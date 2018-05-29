//
//  ViewController.swift
//  AmiracleChatApp
//
//  Created by Amir Nickroo on 5/27/18.
//  Copyright © 2018 Amir Nickroo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference(fromURL: "https://amiraclemessaging.firebaseio.com/")
        ref.updateChildValues(["somevalue": 123123])
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogout))
    }

    @objc func handleLogout() {
        print("Logging Out!")
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
}


