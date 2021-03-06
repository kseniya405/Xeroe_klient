//
//  ContainerViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 8/5/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

enum viewControllerTypes: String {
    case home = "HomeViewController"
    case searchDriver = "SearchDriverViewController"
}


fileprivate let leftMenuIdentifier = "leftMenuVC"

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var tabbarContainerView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    //MARK: - Variables
    
    var initialPos: CGPoint?
    var touchPos: CGPoint?
    let blackTransparentViewTag = 04051993
    var openFlag: Bool = false
    var identifier: viewControllerTypes = .home

    
    var frontVC: UIViewController?
    var leftMenuVC: UIViewController?
    var transformOrder: OrderData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch identifier {
        case .searchDriver:
            frontVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier.rawValue) as! SearchDriverViewController
            let searchVC: SearchDriverViewController = frontVC as! SearchDriverViewController
            searchVC.setCoordinate(startPoint: transformOrder?.collectionData.coordinate, finishPoint: transformOrder?.deliveryData.coordinate, route: transformOrder?.route)
        default:
            frontVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier.rawValue) as! HomeViewController
        }
        leftMenuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: leftMenuIdentifier)
        
        displayTabbar()
        addShadowToView()
        setUpNotifications()
        setUpGestures()
    }
    
    func setUpNotifications(){
        let notificationOpenOrCloseSideMenu = Notification.Name("notificationOpenOrCloseSideMenu")
        NotificationCenter.default.addObserver(self, selector: #selector(openOrCloseSideMenu), name: notificationOpenOrCloseSideMenu, object: nil)
        
        let notificationCloseSideMenu = Notification.Name("notificationCloseSideMenu")
        NotificationCenter.default.addObserver(self, selector: #selector(closeSideMenu), name: notificationCloseSideMenu, object: nil)
        
        let notificationCloseSideMenuWithoutAnimation = Notification.Name("notificationCloseSideMenuWithoutAnimation")
        NotificationCenter.default.addObserver(self, selector: #selector(closeWithoutAnimation), name: notificationCloseSideMenuWithoutAnimation, object: nil)
    }
    
    func setUpGestures(){
        let panGestureContainerView = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        self.view.addGestureRecognizer(panGestureContainerView)
    }
    
    //MARK: - UISetup
    func displayTabbar(){
        // To display Tabbar in TabbarContainerView
        if let currentViewController = frontVC {
            self.addChild(currentViewController)
            currentViewController.didMove(toParent: self)
            
            currentViewController.view.frame = self.tabbarContainerView.bounds
            self.tabbarContainerView.addSubview(currentViewController.view)
        }
    }
    
    func displaySideMenu(){
        // To display LeftMenuViewController in Side Menu View
        if !self.children.contains(leftMenuVC!){
            if let currentViewController = leftMenuVC {
                self.addChild(currentViewController)
                currentViewController.didMove(toParent: self)
                
                currentViewController.view.frame = self.sideMenuView.bounds
                self.sideMenuView.addSubview(currentViewController.view)
                
            }
            
        }
    }
    
    //MARK: - Shadow View
    func addBlackTransparentView() -> UIView{
        //Black Shadow on MainView(i.e on TabBarController) when side menu is opened.
        let blackView = self.tabbarContainerView.viewWithTag(blackTransparentViewTag)
        if blackView != nil{
            return blackView!
        } else {
            let sView = UIView(frame: self.tabbarContainerView.bounds)
            sView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            sView.tag = blackTransparentViewTag
            sView.alpha = 0
            sView.backgroundColor = UIColor.black
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(closeSideMenu))
            sView.addGestureRecognizer(recognizer)
            return sView
        }
        
        
    }
    
    func addShadowToView(){
        //Gives Illusion that main view is above the side menu
        self.tabbarContainerView.layer.shadowColor = shadowColor.cgColor
        self.tabbarContainerView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.tabbarContainerView.layer.shadowRadius = 1
        self.tabbarContainerView.layer.shadowOpacity = 1
        self.tabbarContainerView.layer.borderColor = UIColor.lightGray.cgColor
        self.tabbarContainerView.layer.borderWidth = 0.2
    }

    //MARK: - Selector Methods
    @objc func openOrCloseSideMenu(){
        //Opens or Closes Side Menu On Click of Button
        if openFlag {
            //This closes Left Menu
            let blackTransparentView = self.view.viewWithTag(self.blackTransparentViewTag)
            UIView.animate(withDuration: 0.3, animations: {
                self.tabbarContainerView.frame = CGRect(x: 0, y: 0, width: self.tabbarContainerView.frame.size.width, height: self.tabbarContainerView.frame.size.height)
                blackTransparentView?.alpha = 0
                
            }) { (_) in
                blackTransparentView?.removeFromSuperview()
                self.openFlag = false
            }
        } else {
            //This opens Left Menu
            UIView.animate(withDuration: 0.0, animations: {
                self.displaySideMenu()
                let blackTransparentView = self.addBlackTransparentView()
                
                self.tabbarContainerView.addSubview(blackTransparentView)
                
            }) { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.addBlackTransparentView().alpha = self.view.bounds.width * 0.8/(self.view.bounds.width * 1.8)
                    self.tabbarContainerView.frame = CGRect(x: self.tabbarContainerView.bounds.size.width * 0.8, y: 0, width: self.tabbarContainerView.frame.size.width, height: self.tabbarContainerView.frame.size.height)
                }) { (_) in
                    self.openFlag = true
                }
            }
        }
        
    }
    
    @objc func closeSideMenu(){
        //To close Side Menu
        let blackTransparentView = self.view.viewWithTag(self.blackTransparentViewTag)
        UIView.animate(withDuration: 0.3, animations: {
            self.tabbarContainerView.frame = CGRect(x: 0, y: 0, width: self.tabbarContainerView.frame.size.width, height: self.tabbarContainerView.frame.size.height)
            blackTransparentView?.alpha = 0.0
            
        }) { (_) in
            blackTransparentView?.removeFromSuperview()
            self.openFlag = false
        }
    }
    
    @objc func closeWithoutAnimation(){
        //To close Side Menu without animation
        let blackTransparentView = self.view.viewWithTag(self.blackTransparentViewTag)
        blackTransparentView?.alpha = 0
        blackTransparentView?.removeFromSuperview()
        self.tabbarContainerView.frame = CGRect(x: 0, y: 0, width: self.tabbarContainerView.frame.size.width, height: self.tabbarContainerView.frame.size.height)
        self.openFlag = false
    }
    
    
    
    //MARK: - Pan Gesture
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer){
        //For Pan Gesture
        
        touchPos = panGesture.location(in: self.view)
        let translation = panGesture.translation(in: self.view)
        
        //Add BlackShadowView
        let blackTransparentView = self.addBlackTransparentView()
        self.tabbarContainerView.addSubview(blackTransparentView)
        
        switch panGesture.state {
        case .began:
            initialPos = touchPos
            break
        case .changed:
            let touchPosition = self.view.bounds.width * 0.8
            if (initialPos?.x)! > touchPosition && openFlag{
                //To Close Left Menu
                if self.tabbarContainerView.frame.minX > 0{
                    self.tabbarContainerView.center = CGPoint(x: self.tabbarContainerView.center.x + translation.x, y: self.tabbarContainerView.bounds.midY)
                    panGesture.setTranslation(CGPoint.zero, in: self.view)
                    blackTransparentView.alpha = self.tabbarContainerView.frame.minX/(self.view.bounds.width * 1.8)
                }
            } else if !openFlag{
                //To Open Left Menu
                if translation.x > 0.0{
                    displaySideMenu()
                    
                    self.tabbarContainerView.center = CGPoint(x: self.tabbarContainerView.center.x + translation.x, y: self.tabbarContainerView.bounds.midY)
                    panGesture.setTranslation(CGPoint.zero, in: self.view)
                    blackTransparentView.alpha = self.tabbarContainerView.frame.minX/(self.view.bounds.width * 1.8)
                }
                
            }
            break
        case .ended:
            let isOpen = self.tabbarContainerView.frame.minX > self.view.frame.midX
            
            if isOpen {
                //Opens Left Menu
                UIView.animate(withDuration: 0.3, animations: {
                    self.tabbarContainerView.frame = CGRect(x: self.view.frame.width * 0.8, y: 0, width: self.tabbarContainerView.bounds.width, height: self.tabbarContainerView.bounds.height)
                    blackTransparentView.alpha = self.tabbarContainerView.frame.minX/(self.view.bounds.width * 1.8)
                }) { (_) in
                    self.openFlag = true
                }
            } else {
                //Closes Left Menu
                UIView.animate(withDuration: 0.3, animations: {
                    self.tabbarContainerView.center = CGPoint(x: self.view.center.x, y: self.tabbarContainerView.bounds.midY)
                    blackTransparentView.alpha = 0
                }) { (_) in
                    blackTransparentView.removeFromSuperview()
                    self.openFlag = false
                }
            }
            break
        default: break
        }
    }
    
}

class HamburgerMenu{
    //Class To Implement Easy Functions To Open Or Close LeftVC
    //Make object of this class and call functions
    static func triggerSideMenu(){
        NotificationCenter.default.post(name: NotificationName.notificationOpenOrCloseSideMenu.notification, object: nil)
    }
    
    static func closeSideMenu(){
        NotificationCenter.default.post(name: NotificationName.notificationCloseSideMenu.notification, object: nil)
    }
    
    static func closeSideMenuWithoutAnimation(){
        NotificationCenter.default.post(name: NotificationName.notificationCloseSideMenuWithoutAnimation.notification, object: nil)
    }
    
}

