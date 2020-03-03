//
//  AppViewController.swift
//  FirebaseLab
//
//  Created by Amy Alsaydi on 3/3/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit
import FirebaseAuth

enum ProfileState {
    case editing
    case notEditing
}


class AppViewController: UIViewController {

    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // text feilds
    @IBOutlet weak var displayTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    private var profileState = ProfileState.notEditing
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        laodUserInfo()
        toggleProfileState()
    }
    
    private func laodUserInfo() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        displayNameLabel.text = user.displayName ?? "No display name"
        phoneLabel.text = user.phoneNumber  ?? "No phone number"
        emailLabel.text = user.email ?? "No email"
        
        displayTextField.text = user.displayName
        numberTextField.text = user.phoneNumber
        emailTextField.text = user.email
        
    }
    
    private func toggleProfileState() {
        if profileState == .notEditing {
            displayTextField.isHidden = true
            numberTextField.isHidden = true
            emailTextField.isHidden = true
            updateButton.isHidden = true
        } else if profileState == .editing {
            displayTextField.isHidden = false
            numberTextField.isHidden = false
            emailTextField.isHidden = false
            updateButton.isHidden = false
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        profileState = .editing
        toggleProfileState()
        
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        profileState = .notEditing
        toggleProfileState()
        
        // create request to update profile
        
        guard let displayName = displayTextField.text, !displayName.isEmpty, let email = emailTextField.text, !email.isEmpty else {
            print("missing fields")
            return
        }
        
        let request = Auth.auth().currentUser?.createProfileChangeRequest()
        request?.displayName = displayName
        
        request?.commitChanges(completion: { [unowned self] (error) in
                  if let error = error  {
                      self.showAlert(title: "Profile change", message: "Error changing an alert: \(error) ")
                  } else {
                      self.showAlert(title:"Profile change" , message: "Profile successfully created")
                    self.displayNameLabel.text = displayName
                  }
              })
        
    }
    
}
