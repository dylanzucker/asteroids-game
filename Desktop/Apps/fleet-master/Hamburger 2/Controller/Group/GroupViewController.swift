//
//  GroupViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/13/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit
import HMSegmentedControl

enum GroupPages: Int {
    case contact, members, lists
}

class GroupViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var groupHeaderView: UIView!
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var groupHeaderViewHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    static let storyboardID = "GroupViewController"
    var group: Group?
    var currentUser: Person?
    
    var page: GroupPages = .contact
    var groupPageViewController: GroupPageViewController?
    var isConnected: Bool = false
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fixStatusBarBug()

        // Set-up groupHeaderView
//        setUpGroupHeaderView()
        
        // Set-up segmented control
        setUpSegmentedControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpGroupHeaderView()        
        setNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let group = group {
            groupPageViewController = segue.destination as? GroupPageViewController
            groupPageViewController?.group = group
        }


    }
    
    func setInfo(for group: Group) {
        self.group = group
    }
    
    private func setNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.removeNavigationBarUnderline()

        guard let group = group else {
            return
        }
        
        // Set middle navigation item
        self.navigationItem.titleView = NavigationTitleLabel(withText: "@"+group.username)
        
        // Set right navigation item
        let moreActionsImage = UIImage(named: "dotdotdot")?.withRenderingMode(.alwaysOriginal)
        let rightButtonItem = UIBarButtonItem.init(image: moreActionsImage, style: .plain, target: self, action: #selector(moreActionsClicked))
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        // Set left navigation item
        // set in contacts view controller
    }
    
    // MARK: - User Actions
    @IBAction func groupHeaderConnectButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let data = appDelegate?.allData
            
        if (!isConnected) {
            selectProfile()
            group?.people?.append(currentUser!)
            data?.addGroup(withUsername: group!.username, ofGroup: group!)
        } else {
            group?.removeUserFromGroup(withUsername: currentUser!.username)
            setProfileText(toProfile: 4)
            data?.removeGroup(withUsername: group!.username, ofGroup: group!)
        }
        isConnected = !isConnected
        changeConnectButton()
        updateGroupMembers()
    }
    
    private func changeConnectButton() {
//        if (isConnected) {
//            groupHeaderConnectButton.setImage(UIImage(named: "check_button"), for: .normal)
//        } else {
//            groupHeaderConnectButton.setImage(UIImage(named: "plus_button"), for: .normal)
//        }
    }
    
    @objc private func moreActionsClicked() {
        print("more actions clicked")
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if (isConnected) {
            let followAllButton = UIAlertAction(title: "Follow All", style: .default, handler: { (action) -> Void in
                print("followAllButton button tapped")
            })
        
            let addToFavoritesButton = UIAlertAction(title: "Add To Favorites", style: .default, handler: { (action) -> Void in
                print("addToFavoritesButton button tapped")
            })
        
            let changeProfileButton = UIAlertAction(title: "Change Persona", style: .default, handler: { (action) -> Void in
                let alertController = UIAlertController(title: "Which persona would you like to share with " + (self.group?.name)! + "?", message: nil, preferredStyle: .actionSheet)
                
                let publicButton = UIAlertAction(title: "Public", style: .default, handler: { (action) -> Void in
                    self.setProfileText(toProfile: 0)
                })
                let friendButton = UIAlertAction(title: "Social", style: .default, handler: { (action) -> Void in
                    self.setProfileText(toProfile: 1)
                })
                let workButton = UIAlertAction(title: "Business", style: .default, handler: { (action) -> Void in
                    self.setProfileText(toProfile: 2)
                })
                let familyButton = UIAlertAction(title: "Family", style: .default, handler: { (action) -> Void in
                    self.setProfileText(toProfile: 3)
                })
                
                alertController.addAction(publicButton)
                alertController.addAction(friendButton)
                alertController.addAction(workButton)
                alertController.addAction(familyButton)

                self.navigationController!.present(alertController, animated: true, completion: nil)
            })
        
        
            let addFieldButton = UIAlertAction(title: "Add Field", style: .default, handler: { (action) -> Void in
                print("addFieldButton button tapped")
            })
            
            alertController.addAction(followAllButton)
            alertController.addAction(addToFavoritesButton)
            alertController.addAction(changeProfileButton)
            alertController.addAction(addFieldButton)
        }
        
        let shareGroupButton = UIAlertAction(title: "Share Group", style: .default, handler: { (action) -> Void in
            print("shareGroupButton button tapped")
        })
        alertController.addAction(shareGroupButton)

        if (isConnected) {
            let leaveGroupButton = UIAlertAction(title: "Leave Group", style: .destructive, handler: { (action) -> Void in
                print("leaveGroupButton tapped")
            })
            alertController.addAction(leaveGroupButton)
        }
        
        let blockButton = UIAlertAction(title: "Block", style: .destructive, handler: { (action) -> Void in
            print("Block button tapped")
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        alertController.addAction(blockButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    func selectProfile() {
        let alertController = UIAlertController(title: "Which persona would you like to share with " + (group?.name)! + "?", message: nil, preferredStyle: .actionSheet)
        let publicButton = UIAlertAction(title: "Public", style: .default, handler: { (action) -> Void in
            self.setProfileText(toProfile: 0)
        })
        let friendButton = UIAlertAction(title: "Social", style: .default, handler: { (action) -> Void in
            self.setProfileText(toProfile: 1)
        })
        let workButton = UIAlertAction(title: "Business", style: .default, handler: { (action) -> Void in
            self.setProfileText(toProfile: 2)
        })
        let familyButton = UIAlertAction(title: "Family", style: .default, handler: { (action) -> Void in
            self.setProfileText(toProfile: 3)
        })
        
        alertController.addAction(publicButton)
        alertController.addAction(friendButton)
        alertController.addAction(workButton)
        alertController.addAction(familyButton)

        self.navigationController!.present(alertController, animated: true, completion: nil)
    }
    
    private func setProfileText(toProfile num: Int) {
        let profiles: [String] = ["Public", "Social", "Business", "Family", ""]
//        groupHeaderProfile.text = profiles[num]
    }
    
    private func updateGroupMembers() {
        groupPageViewController?.group = group!
        groupPageViewController?.refreshMembersTable()
    }
    
    // MARK: - Header Set-Up
    private func setUpGroupHeaderView() {
        guard let group = group else {
            return
        }
        print("initial groupHeaderView.height = \(groupHeaderView.frame.height)")
        
        if let profileHeader = Bundle.main.loadNibNamed(ProfileSectionHeaderView.nibName, owner: nil, options: nil)?.first as? ProfileSectionHeaderView  {
            profileHeader.setInfo(for: group, withScreenWidth: view.frame.width)
            
            let newHeaderHeight = getHeightForHeader()
            groupHeaderView.frame = CGRect.init(x: groupHeaderView.frame.minX, y: groupHeaderView.frame.minY, width: groupHeaderView.frame.width, height: newHeaderHeight)
            groupHeaderViewHeight.constant = newHeaderHeight
            groupHeaderView.layoutIfNeeded()
            print("calculated groupHeaderView.height = \(newHeaderHeight)")
            profileHeader.frame = groupHeaderView.bounds
            
            groupHeaderView.addSubview(profileHeader)
        }
    }
    
    private func getHeightForHeader() -> CGFloat {
        guard let group = group else {
            return 230 // default max size
        }
        var cellHeight: CGFloat = 152   // profile bio Label y value
        let font: UIFont = UIFont(name: "Avenir-Roman", size: 14.0)!
        let text = group.bio as NSString
        let constraintSize: CGSize = CGSize(width: 343.0, height: CGFloat.greatestFiniteMagnitude)
        let size: CGRect = text.boundingRect(with: constraintSize, options: [.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: font], context: nil)
        cellHeight += (size.height > 19.124 ? (19.124 * 2.0) : 19.124) + 20; //you can also add a cell padding if you want some space below textView
        
        return cellHeight
    }
    
    // MARK: - Segmented Control Set-Up
    private func setUpSegmentedControl() {
        guard let segmentedControl = self.segmentedControl else {
            return
        }
        
//        segmentedControl.setBottomBorder(withThickness: )
        
        // Set title
        segmentedControl.sectionTitles = ["Contact", "Members", "Lists"]
        segmentedControl.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 16)!, kCTForegroundColorAttributeName : UIColor(red: 135/255, green: 135/255, blue: 135/255, alpha: 100/100)]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 16)!, kCTForegroundColorAttributeName : UIColor.black]
        
        // Set bottom indicator
        segmentedControl.selectionIndicatorHeight = 4
        segmentedControl.selectionIndicatorColor = UIColor.black
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionStyle = .textWidthStripe
        segmentedControl.segmentWidthStyle = .fixed
        segmentedControl.selectedSegmentIndex = page.rawValue
        handleSegmentedControlIndexChange(toPageForIndex: page.rawValue)
        
        // Set edge insets
        segmentedControl.segmentEdgeInset = UIEdgeInsets.zero
        segmentedControl.enlargeEdgeInset = UIEdgeInsets.zero
        
        // Set user interaction
        segmentedControl.isUserInteractionEnabled = true
        segmentedControl.indexChangeBlock = { [unowned self] index in
            self.handleSegmentedControlIndexChange(toPageForIndex: index)
        }
    }
    
    func handleSegmentedControlIndexChange(toPageForIndex index: Int) {
        if (index != page.rawValue) {
            guard let groupPageViewController = self.groupPageViewController else {
                return
            }
            page = GroupPages(rawValue: index)!
            groupPageViewController.adjust(toPage: page)
        }
    }

    
}
