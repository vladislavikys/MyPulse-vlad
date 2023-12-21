//
//  QueueManager.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import RealmSwift

// Менеджер очереди для управления операциями записи в базу данных Realm
class QueueManager {
    // Очередь Realm для выполнения операций записи
    static let realmQueue = DispatchQueue(label: "com.createx.realm.thread.concurrent", qos: .userInitiated, attributes: .concurrent)
}

