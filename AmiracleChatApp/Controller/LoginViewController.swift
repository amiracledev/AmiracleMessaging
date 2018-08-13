//
//  LoginViewController.swift
//  AmiracleChatApp
//
//  Created by Amir Nickroo on 5/27/18.
//  Copyright © 2018 Amir Nickroo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLoginRegister() {
        if loginRegisterSegmentedController.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            self.handleRegister()
        }
    }
    
    func handleLogin() {
        guard let email = emailTextField.text , let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, errr) in
            if errr != nil {
                print(errr ?? "")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    

    
    lazy var loginRegisterSegmentedController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedController.titleForSegment(at: loginRegisterSegmentedController.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        //changing height of inputcontainer view
        inputContainerViewConstraint?.constant = loginRegisterSegmentedController.selectedSegmentIndex == 0 ? 100 : 150
        
        //change height of nametextfield
        nametextFieldheightAnchor?.isActive = false
        nametextFieldheightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedController.selectedSegmentIndex == 0 ? 0 : 1/3)
        nametextFieldheightAnchor?.isActive = true
        
        //Email size
        emailTextFieldContraint?.isActive = false
        emailTextFieldContraint = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedController.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldContraint?.isActive = true
        
        //password size
        passwordTextFieldContraint?.isActive = false
        passwordTextFieldContraint = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedController.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldContraint?.isActive = true
        
    }
    
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
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        return tf
    }()
    let emailSeperator: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        return v
    }()
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "redlogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImagepicker)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedController)
        setupInputsContainer()
        setupLoginRegister()
        setupProfileImageView()
        setupSegmentedController()
    }
    func setupSegmentedController() {
        loginRegisterSegmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedController.centerYAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -25).isActive = true
        loginRegisterSegmentedController.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedController.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    func setupProfileImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedController.topAnchor, constant: -50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    var inputContainerViewConstraint: NSLayoutConstraint?
    var nametextFieldheightAnchor: NSLayoutConstraint?
    var emailTextFieldContraint: NSLayoutConstraint?
    var passwordTextFieldContraint: NSLayoutConstraint?
    
    func setupInputsContainer() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainerViewConstraint = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputContainerViewConstraint?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nametextFieldheightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nametextFieldheightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameSeperator)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeperator)
        inputsContainerView.addSubview(passwordTextField)
        
        
        nameSeperator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeperator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeperator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldContraint = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldContraint?.isActive = true
        
        emailSeperator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeperator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeperator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        passwordTextFieldContraint = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldContraint?.isActive = true
        
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
