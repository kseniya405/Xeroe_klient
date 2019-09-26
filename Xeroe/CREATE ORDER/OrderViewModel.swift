//
//  OrderViewModel.swift
//  Xeroe
//
//  Created by Денис Марков on 9/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

class OrderViewModel: NSObject {
    
    /**
     Sends an order to the server
     */
    func sendOrder(idClient: Int, order: ConfirmOrderByCreator) {
        
        guard let idClient = UserProfile.shared.userableId else {  return }

        RestApi().createOrder(idClient: idClient){ (isOk) in
            DispatchQueue.main.async {
                debugPrint(isOk)
            }
        }
    }
    
}
