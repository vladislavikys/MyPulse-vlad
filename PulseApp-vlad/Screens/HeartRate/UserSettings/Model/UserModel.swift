//
//  UserModel.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import RealmSwift

// Перечисление для представления пола
enum Gender: String, PersistableEnum {
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
enum Units: String, PersistableEnum {
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
public enum AboutMeFieldModel: String, PersistableEnum {
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

// Модель пользователя
@objcMembers
class UserModel: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var gender: Gender = .none
    @Persisted var units: Units = .cmKg
    @Persisted var height: Double = 0.0
    @Persisted var weight: Double = 0.0
    @Persisted var age: Int = 0
    @Persisted var aboutMeWasShow = false
    @Persisted var timeWhenAppWasInstall: Double = 0.0
    @Persisted var showRating = false
    
    // Установка первичного ключа для Realm
    override class func primaryKey() -> String? {
        return #keyPath(UserModel.id)
    }
}

