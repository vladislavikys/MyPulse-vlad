////
////  HeartRateViewModel.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//import UserNotifications
//
//// Протокол для связи с контроллером пульса
//protocol BindWithHeartControllerProtocol {
//    func showAboutMeViewController(heartController: HeartRateController)
//    func calculateAndSaveBPMDataToDB(pulse: [Int])
//    func showAnalyzeVC(heartController: HeartRateController)
//    func handleAnalyzeType(type: AnalyzeTypes)
//    func showResultView(heartController: HeartRateController)
//    func saveBPMSettingsToDB()
//}
//
//// Класс, отвечающий за логику и взаимодействие с данными для контроллера пульса
//class HeartRateViewModel: BindWithHeartControllerProtocol {
//    // Объект настроек пользователя для BPM
//    var userBPMSettings: BPMUserSettings = BPMUserSettings()
//    // Realm - база данных
//    let realm = try! Realm()
//    
//    // Показывает контроллер "Обо мне"
//    func showAboutMeViewController(heartController: HeartRateController) {
//        let aboutMeVC = AboutMeViewController()
//        aboutMeVC.modalPresentationStyle = .fullScreen
//        heartController.present(aboutMeVC, animated: true)
//        UserDefaults.standard.setValue(true, forKey: keyShowAboutMe)
//        
//        // Если нужно сохранить состояние показа "Обо мне" для пользователя в базе данных Realm
//        // if let user = UserManager.getUser() {
//        //     try! realm.safeWrite {
//        //         user.aboutMeWasShow = true
//        //     }
//        // }
//    }
//    
//    // Вычисляет средний пульс и сохраняет в объект настроек пользователя
//    func calculateAndSaveBPMDataToDB(pulse: [Int]) {
//        self.userBPMSettings = BPMUserSettings()
//        var sumPulse = 0
//        _ = pulse.map { sumPulse += $0 }
//        let averagePulse = sumPulse / pulse.count
//        userBPMSettings.bpm = averagePulse
//    }
//    
//    // Показывает контроллер анализа пульса
//    func showAnalyzeVC(heartController: HeartRateController) {
//        let analyzVC = AnalyzViewController()
//        analyzVC.delegate = heartController
//        analyzVC.modalPresentationStyle = .fullScreen
//        heartController.present(analyzVC, animated: true)
//    }
//    
//    // Устанавливает тип анализа для настроек пользователя
//    func handleAnalyzeType(type: AnalyzeTypes) {
//        self.userBPMSettings.analyzeResult = type
//        let dateInterval = Date().timeIntervalSince1970
//        self.userBPMSettings.date = dateInterval
//    }
//    
//    // Показывает экран результата измерения
//    func showResultView(heartController: HeartRateController) {
//        let resultView = ResultScreen()
//        resultView.showWithAnimation(in: heartController.view)
//        resultView.delegate = heartController
//        resultView.updateLabelsValues(bpm: userBPMSettings.bpm, date: userBPMSettings.date, analyzeType: userBPMSettings.analyzeResult, pulsType: userBPMSettings.pulseType)
//        heartController.tabBarController?.view.addSubview(resultView)
//    }
//    
//    // Сохраняет настройки BPM в базе данных
//    func saveBPMSettingsToDB() {
//        BPMUserManager.saveBPMResults(object: userBPMSettings)
//    }
//}
//
