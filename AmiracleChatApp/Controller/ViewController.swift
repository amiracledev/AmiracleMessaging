//
//  ViewController.swift
//  AmiracleChatApp
//
//  Created by Amir Nickroo on 5/27/18.
//  Copyright © 2018 Amir Nickroo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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


