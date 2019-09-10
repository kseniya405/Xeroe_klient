//
//  HomeViewModel.swift
//  Xeroe
//
//  Created by Денис Марков on 9/3/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

class HomeViewModel: NSObject {
    var goToNextScreen: (([String : Any]) -> ())?
    var showAlertInputButtonTap: (() -> ())?
    
    func findUser (xeroeIDTextField: TextFieldWithCorner) {
        
    
        guard var textID = xeroeIDTextField.text, !textID.isEmpty, !textID.contains(" ") else {
            showAlertInputButtonTap?()
            return
        }

        textID.remove(at: textID.startIndex)
        RestApi().findID(xeroeID: textID) { (isOk, dictionaryClientData)  in
            DispatchQueue.main.async {
                guard isOk else {
                    self.showAlertInputButtonTap?()
                    return 
                }
                self.goToNextScreen?(dictionaryClientData)
            }
        }
        return

    }
}

