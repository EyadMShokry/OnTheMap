//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Eyad Shokry on 2/4/19.
//  Copyright © 2019 Eyad Shokry. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButtom: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func onClickLoginButton(_ sender: UIButton) {
        enableControllers(false)
        
        guard let email = emailTextField.text, !email.isEmpty else {
            enableControllers(true)
            raiseAlertView(withTitle: "This Field is required", withMessage: "Email Field Can't be empty")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            enableControllers(true)
            raiseAlertView(withTitle: "This Field is required", withMessage: "Password Field Can't be empty")
            return
        }
        authanticateUser(email: email, password: password)
    }
    
    @IBAction func onClickSignUpButton(_ sender: UIButton) {
        openWithSafari("https://auth.udacity.com/sign-up")
    }
    
    private func authanticateUser(email: String, password: String) {
        Client.shared().authanticateWith(userEmail: email, password: password) { (success, errorMessage) in
            if success {
                self.performUIUpdatesOnMain {
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                }
                self.performSegue(withIdentifier: "navigationController", sender: nil)
            } else {
                self.performUIUpdatesOnMain {
                    self.raiseAlertView(withTitle: "Login Failed", withMessage: errorMessage ?? "Error While Performing Login.")
                }
            }
            self.enableControllers(true)
        }
    }
    
    private func enableControllers(_ enable: Bool) {
        self.enableUI(views: emailTextField, passwordTextField, loginButtom, signUpButton, enable: enable)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
