//
//  Regex.swift
//  Xeroe
//
//  Created by Денис Марков on 10/23/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit

enum CreditCardType : String {
    
    case visa = "Visa"
    case visaElectron = "Visa Electron"
    case mastercard = "Mastercard"
    case maestro = "Maestro"
    case americanExpress = "American Express"
    case dinnersClub = "Dinners Club"
    case discovery = "Discovery"
    case jcb = "JCB"
    
    static var all: [CreditCardType] {
        return [
            .visaElectron,
            .visa,
            .maestro,
            .mastercard,
            .americanExpress,
            .dinnersClub,
            .discovery,
            .jcb
        ]
    }
    
    var pattern: String {
        switch self {
        case .visaElectron: return "^(4026|417500|4508|4844|491(3|7))"
        case .visa: return "^4"
        case .maestro: return "^(5018|5020|5038|5893|6304|6759|676[1-3]|50|56-59|67677[0-4])"
        case .mastercard: return "^(51-55|2221-2720)"
        case .americanExpress: return "^(34|37)"
        case .dinnersClub: return "^(36|30[1-5]|3095|38|39|54)"
        case .discovery: return "^(6011|622126-622925|624000-626999|628200-628899|64|65)"
        case .jcb: return "^(2131|1800|35)"
        }
    }
    
    var image: UIImage {
        switch self {
        case .visa: return #imageLiteral(resourceName: "visa")
        case .visaElectron: return #imageLiteral(resourceName: "visaElectron")
        case .mastercard: return #imageLiteral(resourceName: "mastercard")
        case .maestro: return #imageLiteral(resourceName: "maestro")
        case .americanExpress: return #imageLiteral(resourceName: "americanExpress")
        case .dinnersClub: return #imageLiteral(resourceName: "diners")
        case .discovery: return #imageLiteral(resourceName: "discover")
        case .jcb: return #imageLiteral(resourceName: "jcb")
        }
    }
    
    var paymentSystem: String {
        switch self {
        case .visa: return "Visa"
        case .visaElectron: return "Visa Electron"
        case .mastercard: return "Mastercard"
        case .maestro: return "Maestro"
        case .americanExpress: return "American Express"
        case .dinnersClub: return "Dinners Club"
        case .discovery: return "Discovery"
        case .jcb: return "JCB"
        }
    }
}

struct CreditCardTypeChecker {
    
    func type(for value: String) -> CreditCardType? {
        for creditCardType in CreditCardType.all {
            if isValid(for: creditCardType, value: value) {
                return creditCardType
            }
        }
        return nil
    }
    
    private func isValid(for cardType: CreditCardType, value: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: cardType.pattern,
                                                options: .caseInsensitive)
            
            return regex.matches(in: value,
                                 options: [],
                                 range: NSMakeRange(0, value.count)).count > 0
        } catch {
            return false
        }
    }
}
