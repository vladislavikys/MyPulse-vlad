////
////  RealmExtension.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import RealmSwift
//
//// Расширение для Realm, предоставляющее дополнительные методы для безопасной записи данных
//extension Realm {
//    
//    // Функция для безопасной записи данных в Realm
//    public func safeWrite(_ block: (() throws -> Void)) throws {
//        // Проверка наличия активной транзакции записи
//        if isInWriteTransaction {
//            try block()
//        } else {
//            try write(block)
//        }
//    }
//    
//    // Функция для безопасной записи данных в Realm с завершением
//    public func safeWrite(_ block: (() -> Void), withCompletion completion: (() -> Void)) throws {
//        // Проверка наличия активной транзакции записи
//        if isInWriteTransaction {
//            block()
//            completion()
//        } else {
//            try write(block)
//            completion()
//        }
//    }
//}
//
