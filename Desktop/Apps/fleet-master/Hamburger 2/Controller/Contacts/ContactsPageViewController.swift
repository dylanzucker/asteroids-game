//
//  ContactsPageViewController2.swift
//  Hamburger 2
//
//  Created by Joann Lin on 5/22/18.
//  Copyright © 2018 Fleet. All rights reserved.
//

import UIKit

class ContactsPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // MARK: - Properties
    var onShouldSelectSegmentedIndex: ((Int) -> ())?
    //    var group: Group?
    private var pages = [UIViewController]()
    private var currentViewController: UIViewController!
    private var viewControllerWillTransitionTo: UIViewController!
    private var viewControllerDidFinishTransitionTo: UIViewController!
    private var currentPageIndex: Int {
        return pages.index(of: currentViewController)!
    }
    private var pageAnimationDirection = UIPageViewControllerNavigationDirection.forward
    
    private var peopleViewController: PeopleViewController?
    private var groupsViewController: GroupsViewController?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        
        peopleViewController = storyboard?.instantiateViewController(withIdentifier: PeopleViewController.storyboardID) as? PeopleViewController
        groupsViewController = storyboard?.instantiateViewController(withIdentifier: GroupsViewController.storyboardID) as? GroupsViewController
        
        guard let peopleViewController = self.peopleViewController,
            let groupsViewController = self.groupsViewController else {
                fatalError("Could not instantiate peopleViewController and groupsViewController")
        }
        
        self.pages = [peopleViewController, groupsViewController]
        
        currentViewController = peopleViewController
        setViewControllers([peopleViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
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
    func adjust(toPage page: ContactsPages) {
        switch page {
        case .contacts:
            contactsButtonPressed()
        case .groups:
            groupsButtonPressed()
        }
    }
    
    func contactsButtonPressed() {
        setViewControllers([peopleViewController!], direction: navigationDirectionForController(viewController: peopleViewController!), animated: true, completion: nil)
        currentViewController = peopleViewController
    }
    
    func groupsButtonPressed() {
        setViewControllers([groupsViewController!], direction: navigationDirectionForController(viewController: groupsViewController!), animated: true, completion: nil)
        currentViewController = groupsViewController
    }
    
    func navigationDirectionForController(viewController: UIViewController) -> UIPageViewControllerNavigationDirection {
        return pages.index(of: currentViewController)! > pages.index(of: viewController)! ? .reverse : .forward
    }
    
    // MARK: - UIPageViewControllerDataSource
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
}
