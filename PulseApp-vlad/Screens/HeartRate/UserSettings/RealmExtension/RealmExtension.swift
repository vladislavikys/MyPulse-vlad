//
//  RealmExtension.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import RealmSwift

// MARK: - Расширение для Realm, предоставляющее дополнительные методы для безопасной записи данных
extension Realm {
    
    /// Выполняет безопасную запись данных в Realm.
    /// - Parameter block: Замыкание, в котором выполняются операции записи.
    func safeWrite(_ block: () throws -> Void) rethrows {
        do {
            try self.write(block)
        } catch {
            // Обработайте ошибку или проигнорируйте в зависимости от вашего случая
            print("Error during safe write: \(error)")
        }
    }

    
    /// Выполняет безопасную запись данных в Realm с завершением.
    /// - Parameters:
    ///   - block: Замыкание, в котором выполняются операции записи.
    ///   - completion: Замыкание, которое вызывается после завершения операции записи.
    func safeWrite(_ block: () -> Void, withCompletion completion: () -> Void) {
        do {
            try self.write {
                block()
            }
            completion()
        } catch {
            // Обработайте ошибку или проигнорируйте в зависимости от вашего случая
            print("Error during safe write: \(error)")
        }
    }
}


