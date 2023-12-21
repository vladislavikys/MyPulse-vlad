////
////  PulsTypeButton.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//
//class PulsTypeView: UIButton {
//    
//    // Тип пульса, который отображается кнопкой
//    private var pulsType: PulseType!
//    
//    // Инициализация кнопки с заданным типом пульса
//    init(pulsType: PulseType) {
//        self.pulsType = pulsType
//        super.init(frame: .zero)
//        
//        // Настройка внешнего вида кнопки
//        setupButton(type: pulsType)
//    }
//    
//    // Инициализатор не реализован, так как не предполагается использование загрузки из xib/storyboard
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // Настройка внешнего вида кнопки в зависимости от типа пульса
//    private func setupButton(type: PulseType) {
//        translatesAutoresizingMaskIntoConstraints = false
//        titleLabel?.font = .regularFont(size: 14)
//        titleLabel?.textAlignment = .center
//        layer.cornerRadius = 15.5
//        
//        // Обновление вида кнопки в соответствии с типом пульса
//        updateTypePulse(type: type)
//    }
//    
//    // Обновление вида кнопки в соответствии с переданным типом пульса
//    func updateTypePulse(type: PulseType) {
//        switch type {
//        case .slow:
//            backgroundColor = #colorLiteral(red: 0.8052954078, green: 0.921192348, blue: 0.9749767184, alpha: 1)
//            setTitle("Slow pulse", for: .normal)
//            setTitleColor(UIColor(red: 0.184, green: 0.78, blue: 1, alpha: 1), for: .normal)
//        case .normal:
//            backgroundColor = #colorLiteral(red: 0.8285781741, green: 0.9649079442, blue: 0.9153225422, alpha: 1)
//            setTitle("Normal pulse", for: .normal)
//            setTitleColor(UIColor(red: 0.129, green: 0.816, blue: 0.592, alpha: 1), for: .normal)
//        case .fast:
//            backgroundColor = #colorLiteral(red: 0.9407872558, green: 0.7986612916, blue: 0.8316739202, alpha: 1)
//            setTitle("Fast pulse", for: .normal)
//            setTitleColor(UIColor(red: 0.886, green: 0.165, blue: 0.275, alpha: 1), for: .normal)
//        }
//    }
//}
//
