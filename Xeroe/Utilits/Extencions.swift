//
//  Extencions.swift
//  Xeroe
//
//  Created by Денис Марков on 9/2/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

class Extencions: NSObject {
    
}

extension UIView {
    
    // launch Activity Indicator
    func showActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        
        //location
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 80, height: 80);
        activityIndicator.center = self.center
        
        // style
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = activityIndicatorColor
        activityIndicator.hidesWhenStopped = true
        
        // add and start
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        return activityIndicator
    }
}

extension UILabel {
    
    /**
     sets label parameters and style
     */
    func setLabelStyle(_ textLabel: String, _ fontLabel: UIFont?, _ colorLabel: UIColor) {
        self.text = textLabel
        self.font = fontLabel
        self.textColor = colorLabel
    }
}

extension UIImageView {
    
    //uploads a picture from the link and assigns it to UIImageView
    func getImageFromUrl(urlAvatar: String){
        let url = linkApiStart + urlAvatar
        guard let imgURL: NSURL = NSURL(string: url), let imgData: NSData = NSData(contentsOf: imgURL as URL) else {
            self.image = UIImage(named: "defaultAvatar")
            return
        }
        self.image = UIImage(data: imgData as Data)
    }
}

extension UIViewController {
    func dismiss() {
        let vcs = self.navigationController?.viewControllers
        if ((vcs?.contains(self)) != nil) {
            self.navigationController?.popViewController(animated: false)
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
}

extension UIView {
    
    public enum Animation {
        case down
        case up
        case none
    }
    
    func slideIn(from edge: Animation = .none, x: CGFloat = 0, y: CGFloat = 0, durations: TimeInterval = 1, delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) -> Void {
        
        let offset = offcetFor(edge: edge)
        transform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
        
        isHidden = false
        
        UIView.animate(withDuration: durations, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            
            self.transform = .identity
            self.alpha = 1
            
            
            }, completion: completion)
        
        
        
    }
    
    func slideOut(from edge: Animation = .none, x: CGFloat = 0, y: CGFloat = 0, durations: TimeInterval = 1, delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) -> Void {
        
        let offset = offcetFor(edge: edge)
        let endtransform = CGAffineTransform(translationX: offset.x + x, y: offset.y + y)
        
        UIView.animate(withDuration: durations, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .curveEaseOut, animations: {
            
            self.transform = endtransform
            self.alpha = 1
            
            
        }, completion: completion)
        
        
    }
    
    
    private func offcetFor(edge: Animation) -> CGPoint {
        
        if let size = self.superview?.frame.size {
            
            switch edge {
            case .none :
                return .zero
            case .down:
                return CGPoint(x: 0, y: -frame.maxY)
            case .up:
                return CGPoint(x: 0, y: size.height - frame.minY)
            }
        }
        
        return .zero
    }
}
