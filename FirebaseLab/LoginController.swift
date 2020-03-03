//
//  ViewController.swift
//  FirebaseLab
//
//  Created by Amy Alsaydi on 3/2/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

enum AccountState {
    case existingUser
    case newUser
}

class LoginController: UIViewController {
    
    @IBOutlet weak var recycleImage: UIImageView!
    @IBOutlet weak var accountStateLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTextFeild: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var accountStateMessageLabel: UILabel!
    @IBOutlet weak var accountStateButton: UIButton!
    
    
    
    @IBOutlet weak var logoConstraint: NSLayoutConstraint!
    
    
    
    var originialYConstraint: NSLayoutConstraint!
    
    private var accountState: AccountState = .existingUser
    
    private var keyboardIsVisible = false
    
    override func viewWillLayoutSubviews() {
        loginButton.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextFeild.delegate = self
        passwordTextfield.delegate = self
        registerForKeyboardNotifcations()
        view.backgroundColor = .white
        
        
    }
    
    private func registerForKeyboardNotifcations() {
        // singleton:
        // set the current VC as an observer for notifications from the observer
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print("keyboard shown")
        // here is where we animate the VC and push everyhting up away from the key board.
        if keyboardIsVisible { return }
        originialYConstraint = logoConstraint
        logoConstraint.constant = 20
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        keyboardIsVisible = true
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        print("keyboard hidden")
        resetUI()
        // here is where we animate the VC and push everyhting back down
        
    }
    
    private func resetUI() {
        keyboardIsVisible = false
        logoConstraint.constant = 120
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func toggleAccountState(_ sender: UIButton) {
        // change the account login state
        accountState = accountState == .existingUser ? .newUser : .existingUser
        
        // animation duration
        let duration: TimeInterval = 1.0
        
        if accountState == .existingUser {
            
            UIView.transition(with: self.view, duration: duration, options: [.transitionCrossDissolve], animations: {
                self.accountStateLabel.text = "Login"
                self.loginButton.setTitle("Login", for: .normal)
                self.accountStateMessageLabel.text = "Don't have an account?"
                self.accountStateButton.setTitle("SIGNUP", for: .normal)
            }, completion: nil)
        } else {
            UIView.transition(with: self.view, duration: duration, options: [.transitionCrossDissolve], animations: {
                self.accountStateLabel.text = "Sign Up"
                self.loginButton.setTitle("Sign Up", for: .normal)
                self.accountStateMessageLabel.text = "Already have an account?"
                self.accountStateButton.setTitle("LOGIN", for: .normal)
            }, completion: nil)
        }
    }
}


extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

