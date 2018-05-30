//
//  NewMessageableViewController.swift
//  AmiracleChatApp
//
//  Created by Amir Nickroo on 5/29/18.
//  Copyright © 2018 Amir Nickroo. All rights reserved.
//

import UIKit
import Firebase
class NewMessageableViewController: UITableViewController {

    let cellID = "cellID"
    var users = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        tableView.register(UserCell.self, forCellReuseIdentifier: cellID)
        fetchUsers()
    }
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    func fetchUsers() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot.value!)
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = UserModel()
                user.username   = dictionary["username"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    })
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! UserCell
        
      let user = users[indexPath.row]
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.email
        return cell
    }
}

class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
