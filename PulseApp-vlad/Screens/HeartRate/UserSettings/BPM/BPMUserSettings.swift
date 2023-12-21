//
//  BPMUserSettings.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import RealmSwift

// Перечисление для представления различных типов анализа
@objc
enum AnalyzeTypes: Int, RealmEnum, PersistableEnum {
    case coffee
    case sleep
    case active
    
    // Строковое представление для каждого типа анализа
    var typesString: String {
        switch self {
        case .coffee:
            return NSLocalizedString("Отдых", comment: "")
        case .sleep:
            return NSLocalizedString("Сон", comment: "")
        case .active:
            return NSLocalizedString("Активность", comment: "")
        }
    }
}

// Перечисление для представления различных типов пульса
@objc
enum PulseType: Int, RealmEnum {
    case slow
    case normal
    case fast
    
    // Строковое представление для каждого типа пульса
    var pulseTypesString: String {
        switch self {
        case .slow:
            return NSLocalizedString("Медленный пульс", comment: "")
        case .normal:
            return NSLocalizedString("Нормальный пульс", comment: "")
        case .fast:
            return NSLocalizedString("Быстрый пульс", comment: "")
        }
    }
}

// Класс для хранения настроек пользователя по пульсу в Realm
@objcMembers
class BPMUserSettings: Object {
    // Свойства с использованием атрибута @Persisted от Realm
    @Persisted var id: String = UUID().uuidString
    @Persisted var date: Double = 0.0
    @Persisted var bpm: Int = 0
    dynamic var pulseType: PulseType = .normal
    dynamic var analyzeResult: AnalyzeTypes = .coffee {
        didSet {
            // Обновление типа пульса на основе результата анализа
            switch analyzeResult {
            case .coffee:
                self.pulseType = DefiningPulseType.pulseStateDetermineResting(bpmValue: bpm)
            case .sleep:
                self.pulseType = DefiningPulseType.pulseStateDetermineSleep(bpmValue: bpm)
            case .active:
                self.pulseType = DefiningPulseType.pulseStateDetermineActive(bpmValue: bpm)
            }
        }
    }

    // Переопределение первичного ключа для модели Realm
    override class func primaryKey() -> String? {
        return #keyPath(BPMUserSettings.id)
    }
}

