//
//  LoginViewController.swift
//  AmiracleChatApp
//
//  Created by Amir Nickroo on 5/27/18.
//  Copyright © 2018 Amir Nickroo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        button.setTitle("Regsiter", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Name"
        return tf
    }()
    let nameSeperator: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        return v
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        setupInputsContainer()
        setupLoginRegister()
    }
    
    func setupInputsContainer() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        inputsContainerView.addSubview(nameSeperator)
        
        nameSeperator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeperator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeperator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    func setupLoginRegister() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
}
