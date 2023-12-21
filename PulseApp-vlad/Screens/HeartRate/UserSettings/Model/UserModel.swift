//
//  UserModel.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation

// Перечисление для представления пола
enum Gender: String {
    case male
    case female
    case none
    
    var genderString: String {
        switch self {
        case .male:
            return NSLocalizedString("Male", comment: "")
        case .female:
            return NSLocalizedString("Female", comment: "")
        case .none:
            return NSLocalizedString("Unknown", comment: "")
        }
    }
}

// Перечисление для представления единиц измерения
enum Units: String {
    case cmKg
    case inLbs
    
    var unitsString: String {
        switch self {
        case .cmKg:
            return NSLocalizedString("Cm, Kg", comment: "")
        case .inLbs:
            return NSLocalizedString("In, Lbs", comment: "")
        }
    }
}

// Перечисление для представления полей о пользователе
public enum AboutMeFieldModel: String {
    case gender
    case height
    case weight
    case age
    
    public  var titleText: String {
        switch self {
        case .gender:
            return "Gender"
        case .height:
            return "Height"
        case .weight:
            return "Weight"
        case .age:
            return "Age"
        }
    }
}


