//
//  BPMUserManager.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import RealmSwift

// Менеджер для работы с данными пользовательских настроек по пульсу
class BPMUserManager {
    
    // Singleton-экземпляр менеджера
    static let shared = BPMUserManager()
    
    // Приватный инициализатор для соблюдения паттерна Singleton
    private init() {}
    
    // Получение всех результатов BPM из базы данных Realm
    static func getAllResultsBPM() -> [BPMUserSettings]? {
        let realm = try! Realm()
        // Получение всех объектов BPMUserSettings, отсортированных по дате
        let objects = realm.objects(BPMUserSettings.self).sorted(by: { $0.date < $1.date })
        return Array(objects)
    }
    
    // Сохранение результатов BPM в базу данных Realm
    static func saveBPMResults(object: BPMUserSettings) {
        QueueManager.realmQueue.sync {
            let realm = try! Realm()
            // Безопасная запись объекта в базу данных
            try! realm.safeWrite {
                realm.add(object)
            }
        }
    }
}

