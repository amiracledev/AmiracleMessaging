//
//  LoginController+Handlers.swift
//  AmiracleChatApp
//
//  Created by Amir Nickroo on 5/29/18.
//  Copyright © 2018 Amir Nickroo. All rights reserved.
//

import UIKit
import Firebase
extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func handleProfileImagepicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImagePicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImagePicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImagePicker = originalImage
        }
        if let selectedImage = selectedImagePicker {
            profileImageView.image = selectedImage
        }
    
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Canceledpicker")
        dismiss(animated: true, completion: nil)
    }
    
 func handleRegister() {
        guard let email = emailTextField.text , let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (User, error) in
            if error != nil {
                print("There was an error authenticating")
            }
            guard let uid = User?.user.uid else {
                return
            }
//      Successfullly authenticate user
            let imageName = NSUUID().uuidString
            //storaging data image
            let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
            
                storageRef.putData(uploadData, metadata: nil, completion: { (metaData, Err) in
                    if Err != nil {
                        print(Err!)
                        return
                    }
                    storageRef.downloadURL(completion: { (url, err) in
                        if let err = err{
                            print("Unable to retrieve URL due to error: \(err.localizedDescription)")
                        }
                        let profilePicUrl = url?.absoluteString
                        print("Profile Image successfully uploaded into storage with url: \(profilePicUrl ?? "" )")
                        let values = ["username": name, "email": email, "profileImageUrl": profilePicUrl] as [String : AnyObject]
                        self.registerUserIntoDatabase(uid: uid, values: values)
                    })
            })
           
        }
        print(123)
    }
}

private func registerUserIntoDatabase(uid: String, values: [String: AnyObject]) {
    let ref = Database.database().reference(fromURL: "https://amiraclemessaging.firebaseio.com/")
    let userRef = ref.child("users").child(uid)
    
    userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
        
        if let err = err {
            print(err)
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    })
}
}
