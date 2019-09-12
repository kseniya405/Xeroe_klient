//
//  AgreementViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit

class AgreementTimerViewController: UIViewController {

    @IBOutlet weak var navigationBarLabel: UILabel!
    @IBOutlet weak var alarmImage: UIImageView!
    @IBOutlet weak var waitingForRecipientLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var cancelButton: ButtonWithCornerRadius!{
        didSet {
            cancelButton.layer.borderColor = basicBlueColor.cgColor
            cancelButton.layer.borderWidth = 1
            cancelButton.addTarget(self, action: #selector(noButtonTap), for: .touchUpInside)
        }
    }
    
    var orderViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func noButtonTap() {
        self.dismiss()
    }
    
    func startTimer() {
        var minLeft: Int = 5
        var secLeft: Int = 0
        var timerCount: Int = 299
        //        let confirmationTime = Int.random(in: 0 ..< 290)
        let confirmationTime = 290
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            minLeft = timerCount / 60
            secLeft = timerCount % 60
            self.timerLabel.text = secLeft < 10 ? "\(minLeft):0\(secLeft) min" : "\(minLeft):\(secLeft) min"
            timerCount -= 1
            
            if timerCount == confirmationTime {
                timer.invalidate()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "ResultAgreementViewController") as! ResultAgreementViewController
                initialViewController.isAgreementSuccesful = confirmationTime != 0
                initialViewController.orderViewController = self.orderViewController
                self.navigationController?.pushViewController(initialViewController, animated: false)
            }
        }
    }

}

