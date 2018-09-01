//
//  GroupPageViewController.swift
//  Hamburger 2
//
//  Created by Joann Lin on 11/13/17.
//  Copyright © 2017 Fleet. All rights reserved.
//

import UIKit

class GroupPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // MARK: - Properties
    var onShouldSelectSegmentedIndex: ((Int) -> ())?
//    var group: Group?
    var group: Group = {
        let ad = UIApplication.shared.delegate as! AppDelegate
        return ad.allData!.allGroups[0]
    }() as Group
    
    private var pages = [UIViewController]()
    private var currentViewController: UIViewController!
    private var viewControllerWillTransitionTo: UIViewController!
    private var viewControllerDidFinishTransitionTo: UIViewController!
    private var currentPageIndex: Int {
        return pages.index(of: currentViewController)!
    }
    private var pageAnimationDirection = UIPageViewControllerNavigationDirection.forward
    
    private var groupContactTableViewController: GroupContactTableViewController?
    private var groupMembersTableViewController: GroupMembersTableViewController?
    private var groupListsTableViewController: UITableViewController?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        
        groupContactTableViewController = storyboard?.instantiateViewController(withIdentifier: GroupContactTableViewController.storyboardID) as? GroupContactTableViewController
        groupMembersTableViewController = storyboard?.instantiateViewController(withIdentifier: GroupMembersTableViewController.storyboardID) as? GroupMembersTableViewController
        groupListsTableViewController = UITableViewController()
        
        guard let groupContactTableViewController = self.groupContactTableViewController,
            let groupMembersTableViewController = self.groupMembersTableViewController,
            let groupListsTableViewController = self.groupListsTableViewController else {
            return
        }
        
        groupContactTableViewController.contactInfo = group.contactInfo
        groupMembersTableViewController.members = group.people != nil ? group.people! : []
        groupListsTableViewController.view.backgroundColor = UIColor.orange
        
        self.pages = [groupContactTableViewController, groupMembersTableViewController, groupListsTableViewController]
        
        currentViewController = groupContactTableViewController
        setViewControllers([groupContactTableViewController], direction: .forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Switch Page Functions
    func adjust(toPage page: GroupPages) {
        switch page {
        case .contact:
            contactButtonPressed()
        case .members:
            membersButtonPressed()
        case .lists:
            listsButtonPressed()
        }
    }
    
    func contactButtonPressed() {
        setViewControllers([groupContactTableViewController!], direction: navigationDirectionForController(viewController: groupContactTableViewController!), animated: true, completion: nil)
        currentViewController = groupContactTableViewController
    }
    
    func membersButtonPressed() {
        setViewControllers([groupMembersTableViewController!], direction: navigationDirectionForController(viewController: groupMembersTableViewController!), animated: true, completion: nil)
        currentViewController = groupMembersTableViewController
    }
    
    func listsButtonPressed() {
        setViewControllers([groupListsTableViewController!], direction: navigationDirectionForController(viewController: groupListsTableViewController!), animated: true, completion: nil)
        currentViewController = groupListsTableViewController

    }
    
    func navigationDirectionForController(viewController: UIViewController) -> UIPageViewControllerNavigationDirection {
        print ("current: \(pages.index(of: currentViewController)!)")
        print ("new: \(pages.index(of: viewController)!)")
        print (pages.index(of: currentViewController)! > pages.index(of: viewController)! ? "reverse" : "forward")
        return pages.index(of: currentViewController)! > pages.index(of: viewController)! ? .reverse : .forward
    }
    
    // MARK : - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        currentViewController = viewController
        if currentPageIndex == 0 {
            return nil
        }
        let previousIndex = abs((currentPageIndex - 1) & pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentPageIndex == pages.count - 1 {
            return nil
        }
        let nextIndex = abs((currentPageIndex + 1) & pages.count)
        return pages[nextIndex]
    }
    
    func refreshMembersTable() {
        groupMembersTableViewController?.members = (group.people)!
        groupMembersTableViewController?.tableView.reloadData()
    }

}
