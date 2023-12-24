//
//  UserModel.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import Realm
import RealmSwift

// MARK: - Перечисление для представления пола
enum Gender: String, PersistableEnum {
    case male
    case female
    case none
    
    // Возвращает строковое представление пола
    var genderString: String {
        switch self {
        case .male: return NSLocalizedString("Male", comment: "")
        case .female: return NSLocalizedString("Female", comment: "")
        case .none: return NSLocalizedString("Unknown", comment: "")
        }
    }
}

// MARK: - Перечисление для представления единиц измерения
enum Units: String, PersistableEnum {
    case cmKg
    case inLbs
    
    // Возвращает строковое представление единиц измерения
    var unitsString: String {
        switch self {
        case .cmKg: return NSLocalizedString("Cm, Kg", comment: "")
        case .inLbs: return NSLocalizedString("In, Lbs", comment: "")
        }
    }
}

// MARK: - Перечисление для представления полей о пользователе
enum AboutMeFieldModel: String, CaseIterable {
    case gender = "Gender"
    case height = "Height"
    case weight = "Weight"
    case age = "Age"
    
    // Возвращает текстовое представление поля
    var titleText: String {
        return self.rawValue
    }
}

// MARK: - Модель пользователя
@objcMembers class UserModel: Object {
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
