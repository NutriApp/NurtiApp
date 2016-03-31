//
//  MainNavigationController.swift
//  NutriApp
//
//  Created by Kevin Tran on 3/31/16.
//  Copyright © 2016 Kevin Tran. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    private var mainSelectedObserver: NSObjectProtocol?
    private var leftSelectedObserver: NSObjectProtocol?
    private var rightSelectedObserver: NSObjectProtocol?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    private func addObservers() {
        let center = NSNotificationCenter.defaultCenter()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        mainSelectedObserver = center.addObserverForName(MenuViewController.Notifications.MainSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let mvc = storyboard.instantiateViewControllerWithIdentifier("MainViewController")
            self.setViewControllers([mvc], animated: true)
        }
        
        leftSelectedObserver = center.addObserverForName(MenuViewController.Notifications.LeftSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let rvc = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") 
            self.setViewControllers([rvc], animated: true)
        }
        
        rightSelectedObserver = center.addObserverForName(MenuViewController.Notifications.RightSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let gvc = storyboard.instantiateViewControllerWithIdentifier("RightViewController") 
            self.setViewControllers([gvc], animated: true)
        }
    }
    
    private func removeObservers(){
        let center = NSNotificationCenter.defaultCenter()
        
        if mainSelectedObserver !=  nil {
            center.removeObserver(mainSelectedObserver!)
        }
        if leftSelectedObserver != nil {
            center.removeObserver(leftSelectedObserver!)
        }
        if rightSelectedObserver != nil {
            center.removeObserver(rightSelectedObserver!)
        }
    }
    
}