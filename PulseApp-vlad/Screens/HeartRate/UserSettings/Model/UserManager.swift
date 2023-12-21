//
//  UserManager.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import RealmSwift

// Идентификатор пользователя
let userID = "UserID"

class UserManager {
    
    // Создание пользователя, если его ещё нет в базе данных
    static func createUser() {
        let realm = try! Realm()
        
        if realm.object(ofType: UserModel.self, forPrimaryKey: userID) == nil {
            QueueManager.realmQueue.sync {
                try! realm.safeWrite {
                    let user = UserModel()
                    user.id = userID
                    user.timeWhenAppWasInstall = Date().timeIntervalSince1970
                    realm.add(user)
                }
            }
        }
    }
    
    // Получение пользователя из базы данных
    static func getUser() -> UserModel? {
        let realm = try! Realm()
        
        if let user = realm.object(ofType: UserModel.self, forPrimaryKey: userID) {
            return user
        }
        return nil
    }
}

// Функция для получения настроек пользователя
internal func GetUserSettings() -> UserModel {
    let realm: Realm = try! Realm()
    return realm.object(ofType: UserModel.self, forPrimaryKey: userID)!
}

