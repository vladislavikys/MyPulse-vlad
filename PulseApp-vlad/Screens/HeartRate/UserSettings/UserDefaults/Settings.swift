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
        }
        return isFirstLaunch
    }
    
    // Проверка, нужно ли отображать запрос доступа к камере
    static func showCameraAccess() -> Bool {
        let key = "showCameraAccess"
        let showCameraAccess = !UserDefaults.standard.bool(forKey: key)
        if showCameraAccess {
            UserDefaults.standard.setValue(true, forKey: key)
            UserDefaults.standard.synchronize()
        }
        return showCameraAccess
    }
    
    // Проверка, нужно ли отображать экран "About Me"
    static func showAboutMe() -> Bool {
        let showAboutMe = !UserDefaults.standard.bool(forKey: keyShowAboutMe)
        if showAboutMe {
            UserDefaults.standard.setValue(true, forKey: keyShowAboutMe)
            UserDefaults.standard.synchronize()
        }
        return showAboutMe
    }
}
