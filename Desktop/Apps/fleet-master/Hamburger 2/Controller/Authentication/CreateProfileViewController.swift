//
//  CreateProfileViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 6/11/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    static let storyboardID = "CreateProfileViewController"
    var isRegistering: Bool = false
    var activeField: UITextField = UITextField()
    
    // MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userImageErrorLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberErrorLabel: UILabel!
    
    var textFields = [UITextField]()
    var errors = [UILabel]()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFields = [
            nameTextField,
            emailTextField,
            usernameTextField,
            passwordTextField,
            phoneNumberTextField
        ]
        
        errors = [
            userImageErrorLabel,
            nameErrorLabel,
            emailErrorLabel,
            usernameErrorLabel,
            passwordErrorLabel,
            phoneNumberErrorLabel
        ]

        for error in errors {
            error.isHidden = true
        }
        
        for textField in textFields {
            textField.delegate = self
            textField.returnKeyType = .next
            textField.setBottomBorder(withThickness: 1.0)
        }
        
        userImageView.circleBorder(withCornerRadius: 35.0)
        
        // page UI set-up
        if (isRegistering) {
            userImageView.image = UIImage(named: "empty_image")!
            
            for textField in textFields {
                textField.text = ""
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
        
        // registerForKeyboardNotifications
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.removeObserver(self)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    private func setNavigationBar() {
//      code that makes nav bar transparent
//        if let nc = self.navigationController {
//            nc.navigationBar.isTranslucent = false
//            nc.navigationBar.shadowImage = UIImage()
//            nc.view.backgroundColor = UIColor.clear
//            nc.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//            nc.navigationBar.backgroundColor = UIColor.clear
//        }
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        removeNavigationBarUnderline()
        setBackButton()
        
        // Set right navigation item
         let rightButtonItem = UIBarButtonItem.init(title: "Next", style: .plain, target: self, action: #selector(clickedNext))
        rightButtonItem.setTitleTextAttributes(
            [NSAttributedStringKey.foregroundColor: Constants.AppSettings.StartingPage.disabledNextButtonColor,
             NSAttributedStringKey.font: (UIFont(name: "Avenir-Black", size: 16) ?? UIFont(name: "System", size: 16))!
            ],
            for: .normal)
        self.navigationItem.rightBarButtonItem = rightButtonItem

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // User actions
    @objc private func clickedNext() {
        print("clicked next")
        
        
        //TODO - profile image error label
        //TODO - add checks for email, password, phone number
        nameErrorLabel.isHidden = !(nameTextField.text == "")
        emailErrorLabel.isHidden = !(emailTextField.text == "")
        usernameErrorLabel.isHidden = !(usernameTextField.text == "")
        passwordErrorLabel.isHidden = !(passwordTextField.text == "")
        phoneNumberErrorLabel.isHidden = !(phoneNumberTextField.text == "")

        
        for error in errors {
            if (!error.isHidden) {
                //TODO enable return - temp disabled for development
                //return
            }
        }
        
        guard let createIDsVC = storyboard?.instantiateViewController(withIdentifier: LoginViewController.storyboardID) as? LoginViewController else {
            print("error creating LoginViewController")
            return
        }
        self.navigationController?.pushViewController(createIDsVC, animated: true)

    }
}

extension CreateProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {

        // CHANGE NEXT text color when finished filling fields
//        var allFieldsFilled: Bool = true
//
//        for textField in textFields {
//            if (textField.text == "") {
//                allFieldsFilled = false
//            }
//        }
//
//        if (allFieldsFilled) {
//            let rightButtonItem = self.navigationItem.rightBarButtonItem
//            rightButtonItem?.setTitleTextAttributes(
//                [NSAttributedStringKey.foregroundColor: Constants.AppSettings.StartingPage.enabledNextButtonColor,
//                 NSAttributedStringKey.font: (UIFont(name: "Avenir-Black", size: 16) ?? UIFont(name: "System", size: 16))!
//                ],
//                for: .normal)
//            self.navigationItem.rightBarButtonItem = rightButtonItem
//        }
    }
    
//    @objc private func keyboardWillShow(notification: NSNotification) {
//
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            print("shifted up")
//            print("   ksh: \(keyboardSize.height)")
//            let heightToAdd = keyboardSize.height + 20
//            loginButtonBottomConstraint.constant = loginButtonBottomHeight + heightToAdd
//            fleetLabelBottomConstraint.constant = fleetLabelBottomHeight - heightToAdd
//
//            UIView.animate(withDuration: 0.2, animations: {self.view.layoutIfNeeded()})
//
//            print("   new height: \(loginButtonBottomConstraint.constant)")
//        }
//
//
//
//    }
//
//    @objc private func keyboardWillHide(notification: NSNotification) {
//        print("shifted down")
//        loginButtonBottomConstraint.constant = loginButtonBottomHeight
//        fleetLabelBottomConstraint.constant = fleetLabelBottomHeight
//        UIView.animate(withDuration: 0.5, animations: {self.view.layoutIfNeeded()})
//        print("   new height: \(loginButtonBottomConstraint.constant)")
//    }
}


// OLD SCROLL CODE
//
//    @objc private func keyboardWasShown(_ notification: NSNotification) {
//        guard let info = notification.userInfo, let keyboard = info[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
//            return
//        }
//
//        let kbSize: CGSize = keyboard.cgRectValue.size
//        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
//        self.scrollView.contentInset = contentInsets
//        self.scrollView.scrollIndicatorInsets = contentInsets
//        // If active text field is hidden by keyboard, scroll it so it's visible
//        // Your app might not need or want this behavior.
//        var aRect: CGRect = view.frame
//        aRect.size.height -= kbSize.height
//        if !aRect.contains(activeField.frame.origin) {
//            scrollView.scrollRectToVisible(activeField.frame, animated: true)
//        }
//    }
//
//    @objc private func keyboardWillBeHidden(_ notification: NSNotification) {
//        let contentInsets: UIEdgeInsets = .zero
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//    }

