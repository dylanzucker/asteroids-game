//
//  UIViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/26/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func setTabViewSettings() {
        fixStatusBarBug()
        setBackButtonImage()
        setTabBarItems()
    }
    
    private func setBackButtonImage() {
        
        guard let navigationController = self.navigationController else {
            return
        }

        let backImage = UIImage(named: "back_arrow")?.withRenderingMode(.alwaysOriginal)
        navigationController.navigationBar.backIndicatorImage = backImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController.navigationBar.tintColor = .black

//        self.navigationItem.hidesBackButton = true
//
//        let button: UIButton = UIButton (type: .custom)
//        button.setImage(UIImage(named: "back_arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(self, action: Selector("backButtonPressed:"), for: .touchUpInside)
//        button.frame = CGRectMake(10, 0, 30, 30)
//        let barButton = UIBarButtonItem(customView: button)
//
//        self.navigationItem.leftBarButtonItem = barButton
    }

    func setBackButton() {
        let button: UIButton = UIButton (type: .custom)
        button.setImage(UIImage(named: "back_arrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.frame = CGRectMake(0, 0, 15, 15)
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backButtonPressed(btn : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setBackButton(withNavigationController navigationController: UINavigationController, withNavigationItem navigationItem: UINavigationItem) {
        let backImage = UIImage(named: "back_arrow")?.withRenderingMode(.alwaysOriginal)
        navigationController.navigationBar.backIndicatorImage = backImage
        navigationController.navigationBar.backIndicatorTransitionMaskImage = backImage
        navigationController.navigationBar.tintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func removeNavigationBarUnderline() {
        guard let navBar = self.navigationController?.navigationBar else {
            return
        }
        
        navBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.white), for: UIBarMetrics.default)
        navBar.isTranslucent = false
        navBar.shadowImage = UIImage()
    }
    
    func fixStatusBarBug() {
        //all others:
        var view = UIView(frame: CGRectMake(0, 0, 500, 20))
        //iPhone X:
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
           view = UIView(frame: CGRectMake(0, 0, 500, 44))
        }
        view.backgroundColor = UIColor.white
        self.navigationController?.view.addSubview(view)
    }
    
    func fixStatusBarBugSettings() {
        let view = UIView(frame: CGRectMake(0, 0, 500, 20))
        view.backgroundColor = UIColor.init(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        self.navigationController?.view.addSubview(view)
    }
    
    private func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func setTabBarItems() {
        // Contacts
        self.tabBarController?.tabBar.items![0].image = UIImage(named: "contacts_icon")
        self.tabBarController?.tabBar.items![0].title = ""
        self.tabBarController?.tabBar.items![0].selectedImage = UIImage(named: "contacts_icon")
        
        // Search
        self.tabBarController?.tabBar.items![1].image = UIImage(named: "search_icon")
        self.tabBarController?.tabBar.items![1].title = ""
        self.tabBarController?.tabBar.items![1].selectedImage = UIImage(named: "search_icon")
        
        // Notifications
        self.tabBarController?.tabBar.items![2].image = UIImage(named: "notifications_icon")
        self.tabBarController?.tabBar.items![2].title = ""
        self.tabBarController?.tabBar.items![2].selectedImage = UIImage(named: "notifications_icon")
                
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let currentUser = appDelegate.myUser
        var profileImage = UIImage(named: (currentUser?.photo_key)!)?.roundedImage.resizedImage(newWidth: 25).withRenderingMode(.alwaysOriginal)
        
        if profileImage == nil {
            profileImage = UIImage(named: "default_user_img")?.roundedImage.resizedImage(newWidth: 25).withRenderingMode(.alwaysOriginal) // NEED
        }
        
        self.tabBarController?.tabBar.items![3].image = profileImage
        self.tabBarController?.tabBar.items![3].title = ""
        self.tabBarController?.tabBar.items![3].selectedImage = profileImage
    }
    
    func goToProfile(of person: Person, using navController: UINavigationController?) {
        guard let profileView = self.storyboard?.instantiateViewController(withIdentifier: ProfileTableViewController.storyboardID) as? ProfileTableViewController, let navController = navController else {
            return
        }
        
        // Set person in profile controller
        profileView.person = person
        
        navController.pushViewController(profileView, animated: true)
    }
    
    func hideNavBar(_ navController: UINavigationController, _ view: UIView) {
        let navBarFrame = navController.navigationBar.frame
        navController.navigationBar.frame.origin.y -= navBarFrame.height
        let viewFrame = view.frame
        print("1 BEFORE: \(navBarFrame.height) \(view.frame.size.height)")

        view.frame.origin.y -= navBarFrame.height;
        view.frame.size.height += navBarFrame.height;
        print("1 AFTER: \(navBarFrame.height) \(view.frame.size.height)")

//
//        // The normal navigation bar frame, i.e. fully visible
//        let normalNavBarFrame = navController.navigationBar.frame;
//
//        // The frame of the hidden navigation bar (moved up by its height)
//        var hiddenNavBarFrame = normalNavBarFrame;
//        print("original origin: \(hiddenNavBarFrame.origin.y)")
//        hiddenNavBarFrame.origin.y -= normalNavBarFrame.height;
//
//        // The frame of your view as specified in the nib file
//        let normalViewFrame = view.frame;
//
//        // The frame of your view moved up by the height of the navigation bar
//        // and increased in height by the same amount
//        var fullViewFrame = normalViewFrame;
//        fullViewFrame.origin.y -= normalNavBarFrame.height;
//        print("height in hide: \(fullViewFrame.size.height)")
//        fullViewFrame.size.height += normalNavBarFrame.height;
//
//        navController.navigationBar.frame = hiddenNavBarFrame
//        self.view.frame = fullViewFrame
    }
    
    func showNavBar(_ navController: UINavigationController, _ view: UIView) {
        let navBarFrame = navController.navigationBar.frame
        let viewFrame = view.frame
        
        navController.navigationBar.frame.origin.y += navBarFrame.height
        print("2 BEFORE: \(navBarFrame.height) \(view.frame.size.height)")
        
        view.frame.origin.y += navBarFrame.height;
        view.frame.size.height -= navBarFrame.height;
        print("2 AFTER: \(navBarFrame.height) \(view.frame.size.height)")

        // The normal navigation bar frame, i.e. fully visible
//        var normalNavBarFrame = navController.navigationBar.frame;
//        normalNavBarFrame.origin.y = 0
//
//        navController.navigationBar.frame = normalNavBarFrame
//
//        var normalViewFrame = self.view.frame;
//        normalViewFrame.origin.y = 0
//        print("height in show: \(normalViewFrame.size.height)")
//        normalViewFrame.size.height = normalViewFrame.size.height
//
//        self.view.frame = normalViewFrame
    }

}
