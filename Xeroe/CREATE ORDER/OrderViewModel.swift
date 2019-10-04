//
//  OrderViewModel.swift
//  Xeroe
//
//  Created by Денис Марков on 9/10/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation

class OrderViewModel: NSObject {
    
    var goToNextScreen: (() -> ())?

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
    
    /**
     Sets cell parameters ClientDataTableViewCell.
     Accepts an empty cell, returns a cell with data.
     */
    func setParametersClientDataTableViewCell(cell: ClientDataTableViewCell, isSender: Bool, clientDataDictionary: [String : Any]) -> ClientDataTableViewCell {
        
        let id = (isSender ? UserProfile.shared.xeroeId : clientDataDictionary["xeroeid"] as? String) ?? "Wrong data"
        let nameUser = (isSender ? UserProfile.shared.email : clientDataDictionary["email"] as? String) ?? "Wrong data"
        let phone = (isSender ? UserProfile.shared.phone : clientDataDictionary["phone"] as? String) ?? "Wrong data"
        let address = isSender ? userAddress : clientAddress
        let avatar = isSender ? UserProfile.shared.avatar : clientDataDictionary["avatar"] as? String
        guard let urlAvatar = avatar else { return cell }
        
        cell.setParameters(id: id, name: nameUser, phone: phone, address: address, avatar: urlAvatar)
        return cell
    }
    
}
