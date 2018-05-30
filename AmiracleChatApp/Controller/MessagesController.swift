//
//  ViewController.swift
//  AmiracleChatApp
//
//  Created by Amir Nickroo on 5/27/18.
//  Copyright © 2018 Amir Nickroo. All rights reserved.
//

import UIKit
import Firebase
class MessagesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let ref = Database.database().reference(fromURL: "https://amiraclemessaging.firebaseio.com/")
//        ref.updateChildValues(["somevalue": 123123])
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = UIImage(named: "iconNewMessage")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        checkUserLoggedIn()
    }
    @objc func handleNewMessage() {
     let newMessageController = NewMessageableViewController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    func checkUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject] {
                self.navigationItem.title = dictionary["username"] as? String
                }
            })
            
        }
        
    }

    @objc func handleLogout() {
        print("Logging Out!")
        do {
        try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginViewController()
        present(loginController, animated: true, completion: nil)
    }
    
func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
}


