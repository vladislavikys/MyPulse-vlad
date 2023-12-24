//
//  Settings.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation

// Ключ для отображения экрана "About Me"
let keyShowAboutMe = "showAboutMe"

// Расширение UserDefaults для работы с настройками приложения
extension UserDefaults {
    
    // Проверка, является ли текущий запуск приложения первым
    static func isFirstLaunch() -> Bool {
        let key = "isFirstLaunch"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: key)
        if isFirstLaunch {
            UserDefaults.standard.setValue(true, forKey: key)
            UserDefaults.standard.synchronize()
            print("isFirstLaunch")
        }
        return isFirstLaunch
    }
    
    
}
