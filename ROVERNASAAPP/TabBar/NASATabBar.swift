//
//  NASATabBar.swift
//  ROVERNASAAPP
//
//  Created by Cristian guillermo Romero garcia on 04/12/23.
//

import UIKit

class NASATabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews(){
        let photoViewController = PhotoViewController(nibName: "PhotoViewController", bundle: nil)
        photoViewController.tabBarItem.title = "Daily Photo"
        photoViewController.tabBarItem.image = UIImage(systemName: "camera.circle")
        photoViewController.tabBarItem.selectedImage = UIImage(systemName: "camera.circle.fill")
        let photoNavigation = UINavigationController(rootViewController: photoViewController)
        
        let roversViewController = RoversViewController(nibName: "RoversViewController", bundle: nil)
        roversViewController.tabBarItem.title = "Rover Photo"
        roversViewController.tabBarItem.image = UIImage(systemName: "eye.circle")
        roversViewController.tabBarItem.selectedImage = UIImage(systemName: "eye.circle.fill")
        let roversNavigation = UINavigationController(rootViewController: roversViewController)
        let viewController = [photoNavigation, roversViewController]
        self.viewControllers = viewController
        self.selectedIndex = 0
        self.tabBar.backgroundColor = .systemBackground
        
    }

}
