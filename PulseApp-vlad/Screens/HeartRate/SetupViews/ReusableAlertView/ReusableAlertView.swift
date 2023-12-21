//
//  ReusableAlertView.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit

// Протокол делегата для обработки действий в представлении всплывающего окна
protocol AlertViewDelegate: AnyObject {
    func tappedActionInPrivacyView(forType type: PrivacyType)
}

// Возможные типы всплывающих окон
enum PrivacyType {
    case preview
    case camera
}

class ReusableAlertView: UIView {
    // UI-элементы всплывающего окна
    private var titleLabel = UILabel()
    private var bodyLabel = UILabel()
    private var button = PublicButton()
    
    // Ссылка на делегата для обработки событий всплывающего окна
    weak var delegate: AlertViewDelegate?
    
    // Темный фон для затемнения основного интерфейса
    weak var darkView: UIVisualEffectView?
    
    // Инициализатор с передачей типа всплывающего окна
    init(type: PrivacyType) {
        super.init(frame: .zero)
        setupViews(forType: type)
    }
    
    // Метод, вызываемый при создании экземпляра из Interface Builder (не используется в данном коде)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка UI в соответствии с типом всплывающего окна
    func setupViews(forType type: PrivacyType) {
        // Добавление UI-элементов на представление
        addSubview(titleLabel)
        addSubview(bodyLabel)
        addSubview(button)
        
        // Настройка общих свойств для всплывающего окна
        backgroundColor = .white
        layer.cornerRadius = 30
        clipsToBounds = true
        
        // Настройка заголовка
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .mediumFont(size: 20)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        
        // Настройка основного текста
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.font = .regularFont(size: 16)
        bodyLabel.textAlignment = .center
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        
        // Установка текста и действий для кнопки в соответствии с типом всплывающего окна
        switch type {
        case .preview:
            titleLabel.text = "Welcome to Pulse"
            bodyLabel.text = "By clicking \"Accept and Continue\", you confirm that you have read and accept our Privacy Policy Terms of Service"
            button.setTitle("Accept and Continue", for: .normal)
            button.addTarget(self, action: #selector(dissmisPreview), for: .touchUpInside)
        case .camera:
            titleLabel.text =  "Camera Access"
            bodyLabel.text = "Pulse would like to access your camera to measure heart rate by collecting the light changes of your finger surface"
            button.setTitle("OK", for: .normal)
            button.addTarget(self, action: #selector(dismissCameraAccess), for: .touchUpInside)
        }
        
        // Установка constraint'ов для позиционирования элементов
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 40),
            bodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            button.heightAnchor.constraint(equalToConstant: 68),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
        ])
    }
    
    // Обработчик нажатия кнопки "Accept and Continue"
    @objc private func dissmisPreview() {
        delegate?.tappedActionInPrivacyView(forType: .preview)
    }
    
    // Обработчик нажатия кнопки "OK" для доступа к камере
    @objc private func dismissCameraAccess() {
        delegate?.tappedActionInPrivacyView(forType: .camera)
    }
}

