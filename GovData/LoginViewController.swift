//
//  ViewController.swift
//  GovData
//
//  Created by David Celentano on 4/9/18.
//  Copyright © 2018 David Celentano. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    // MARK: UI elements
    // setting up UI elements
    
    private let titleImageView: UIImageView = {
        let i = UIImageView()
        i.image = #imageLiteral(resourceName: "GreatSeal")
        return i
    }()
    
    private let titleLabel: UILabel = {
        let l = UILabel()
        //l.textColor = UIColor.white
        l.numberOfLines = 0
        l.text = "Welcome to GovData"
        return l
    }()
    
    private let loginLabel: UILabel = {
        let l = UILabel()
        //l.textColor = UIColor.white
        l.numberOfLines = 0
        l.text = "Login"
        return l
    }()
    
    private let usernameTextField: UITextField = {
        let t = UITextField()
        //t.backgroundColor = UIColor.white
        t.borderStyle = .roundedRect
        t.autocapitalizationType = .none
        t.clearButtonMode = .always
        return t
    }()
    
    private let passwordTextField: UITextField = {
        let t = UITextField()
        //t.backgroundColor = UIColor.white
        t.isSecureTextEntry = true
        t.returnKeyType = .search
        t.borderStyle = .roundedRect
        t.autocapitalizationType = .none
        t.clearButtonMode = .always
        return t
    }()
    
    private let loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Login", for: .normal)
        //b.addTarget(self, action: #selector(SOME METHOD), for: .touchUpInside)
        return b
    }()
    
    private let guestLoginButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Continue as guest", for: .normal)
        //b.addTarget(self, action: #selector(SOME METHOD), for: .touchUpInside)
        return b
    }()
    

    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleImageView)
        titleImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(30)
            make.size.equalTo(100)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalTo(titleLabel)
        }

        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(loginLabel.snp.bottom).offset(15)
            make.centerX.equalTo(titleLabel)
            make.width.greaterThanOrEqualTo(150)
        }

        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.centerX.equalTo(titleLabel)
            make.width.greaterThanOrEqualTo(150)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.centerX.equalTo(titleLabel)
        }

        view.addSubview(guestLoginButton)
        guestLoginButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(25)
            make.centerX.equalTo(titleLabel)
        }
    }

}

// MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    // when users press return on the keyboard, start the search
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TODO ensure username and password exist before logging in
//        if var username = usernameTextField.text {
//            // trim any trailing whitespace for autocomplete
//            username = username.trimmingCharacters(in: .whitespaces)
//            // send the API request
//            sendAPIRequest(for: username)
//        }
        return false
    }
}

