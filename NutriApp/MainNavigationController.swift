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
    private var manageProgressSelectedObserver: NSObjectProtocol?
    private var planSelectedObserver: NSObjectProtocol?
    private var manageSupporterSelectedObserver: NSObjectProtocol?
    private var supportingSelectedObserver: NSObjectProtocol?
    private var calendarSelectedObserver: NSObjectProtocol?
    private var profileSelectedObserver: NSObjectProtocol?

    
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
        
        manageProgressSelectedObserver = center.addObserverForName(MenuViewController.Notifications.ManageProgressSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let vc = storyboard.instantiateViewControllerWithIdentifier("ManageProgressViewController")
            self.setViewControllers([vc], animated: true)
        }
        
        planSelectedObserver = center.addObserverForName(MenuViewController.Notifications.PlanSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let vc = storyboard.instantiateViewControllerWithIdentifier("PlanViewController")
            self.setViewControllers([vc], animated: true)
        }
        
        manageSupporterSelectedObserver = center.addObserverForName(MenuViewController.Notifications.ManageSupporterSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let vc = storyboard.instantiateViewControllerWithIdentifier("ManageSupporterViewController")
            self.setViewControllers([vc], animated: true)
        }
        
        supportingSelectedObserver = center.addObserverForName(MenuViewController.Notifications.SupportingSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let vc = storyboard.instantiateViewControllerWithIdentifier("SupportingViewController")
            self.setViewControllers([vc], animated: true)
        }
        
        calendarSelectedObserver = center.addObserverForName(MenuViewController.Notifications.CalendarSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let vc = storyboard.instantiateViewControllerWithIdentifier("CalendarViewController")
            self.setViewControllers([vc], animated: true)
        }
        
        calendarSelectedObserver = center.addObserverForName(MenuViewController.Notifications.ProfileSelected, object: nil, queue: nil) { (notification: NSNotification!) in
            let vc = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController")
            self.setViewControllers([vc], animated: true)
        }
    }
    
    private func removeObservers(){
        let center = NSNotificationCenter.defaultCenter()
        
        if mainSelectedObserver !=  nil {
            center.removeObserver(mainSelectedObserver!)
        }
        if manageProgressSelectedObserver != nil {
            center.removeObserver(manageProgressSelectedObserver!)
        }
        if planSelectedObserver != nil {
            center.removeObserver(planSelectedObserver!)
        }
        if manageSupporterSelectedObserver != nil {
            center.removeObserver(manageSupporterSelectedObserver!)
        }
        if supportingSelectedObserver != nil {
            center.removeObserver(supportingSelectedObserver!)
        }
        if calendarSelectedObserver != nil {
            center.removeObserver(calendarSelectedObserver!)
        }
        if profileSelectedObserver != nil {
            center.removeObserver(profileSelectedObserver!)
        }
    }
    
}