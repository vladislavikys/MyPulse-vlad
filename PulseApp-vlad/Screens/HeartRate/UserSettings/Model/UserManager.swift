import Foundation
import RealmSwift

class UserManager {
    // Идентификатор пользователя
    private static let userID = "UserID"

    // MARK: - Менеджер пользователя

    static func createUser() {
        let realm = try! Realm()
        do {
            if realm.object(ofType: UserModel.self, forPrimaryKey: userID) == nil {
                try QueueManager.realmQueue.sync {
                    try realm.safeWrite {
                        let user = UserModel()
                        user.id = userID
                        user.timeWhenAppWasInstall = Date().timeIntervalSince1970
                        realm.add(user)
                        print("add realm user")
                    }
                }
            }
        } catch {
            print("Error creating user: \(error)")
        }
    }

    static func getUser() -> UserModel? {
        let realm = try! Realm()
        return realm.object(ofType: UserModel.self, forPrimaryKey: userID)
    }

    // MARK: - Функция для получения настроек пользователя

    static func getUserSettings() -> UserModel {
        let realm = try! Realm()
        return realm.object(ofType: UserModel.self, forPrimaryKey: userID)!
    }
}
