//
//  TempViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 2/13/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit
import FacebookCore // for AccessToken
import FacebookLogin

enum socialAPIType: String {
    case facebook = "facebook"
    case twitter = "twitter"    //DC
    case pinterest = "pinterest"    // DC
}

class TempViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    var socialAPI: socialAPIType = .facebook
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a custom login button to your app
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect.init(x: 0, y: 0, width: 180, height: 40)
        myLoginButton.center = view.center;
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(self.fbLoginButtonClicked), for: .touchUpInside)
        
        // Add the button to the view
        view.addSubview(myLoginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func fbLoginButtonClicked() {
        print("fb login called")
        if let accessToken = AccessToken.current {
            guard let userID = accessToken.userId else {
                print("no userID found")
                return
            }
            let profileURLMobile = URL(string: "fb://profile/\(userID)")!
            let profileURLWeb = URL(string: "https://www.facebook.com/\(userID)")!
            if UIApplication.shared.canOpenURL(profileURLMobile) {
                print("CAN OPEN APP")
                UIApplication.shared.open(profileURLMobile, options: [:]) { (success) in print("opened facebook app?: \(success)")}
            } else {
                print("CAN'T OPEN APP")
                UIApplication.shared.open(profileURLWeb, options: [:], completionHandler: nil)
            }
            return
        }
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .userFriends, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
            }
        }
    }

    @objc func pinterestLoginButtonClicked() {
        print("pinterest login called")
        let fleetRedirectURL = URL(string: "fun.fleet.fleet://")!
        let clientID = "4950505071665234192"
        let accessCodeURL = URL(string: "https://api.pinterest.com/oauth/?response_type=code&redirect_uri=\(fleetRedirectURL)&client_id=\(clientID)&scope=read_relationships,write_relationships&state=768uyFys")!
        UIApplication.shared.open(accessCodeURL, options: [:], completionHandler: nil)
        
//        UIApplication.shared.open(fleetRedirectURL, options: [:], completionHandler: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
