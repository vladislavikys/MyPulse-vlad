////
////  UnitsView.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//
//class UnitsView: UIView {
//    
//    public weak var unitsDelegate: UnitsDelegate?
//    private var units: Units
//    private var imageView: UIImageView!
//    private var unitsLabel: UILabel!
//    
//    init(units: Units) {
//        self.units = units
//        super.init(frame: .zero)
//        setupView(unitsText: units.unitsString)
//        tapGesture()
//        setupLayout()
//    }
//    
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupView(unitsText: String) {
//        // Создание и настройка изображения
//        imageView = UIImageView(image: UIImage(named: "FullRectangle"))
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Создание и настройка метки
//        unitsLabel = UILabel()
//        unitsLabel.font = .regularFont(size: 15)
//        unitsLabel.textColor = .white
//        unitsLabel.text = unitsText
//        unitsLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Добавление элементов на представление
//        self.addSubview(imageView)
//        self.addSubview(unitsLabel)
//    }
//    
//    private func setupLayout() {
//        // Настройка констрейнтов для изображения и метки
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageView.topAnchor.constraint(equalTo: self.topAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            
//            unitsLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
//            unitsLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
//        ])
//    }
//    
//    public func changeColor(isSelected: Bool) {
//        // Изменение цвета текста метки в зависимости от выбора
//        self.unitsLabel.textColor = UIColor(cgColor: isSelected == true ? .init(red: 1, green: 1, blue: 1, alpha: 1) : .init(red: 0.4, green: 0.463, blue: 0.98, alpha: 1))
//    }
//    
//    private func tapGesture() {
//        // Настройка жеста нажатия
//        self.isUserInteractionEnabled = true
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAndChooseUnits)))
//    }
//    
//    @objc private func tapAndChooseUnits() {
//        // Обработка нажатия и уведомление делегата о выборе единиц измерения
//        self.unitsDelegate?.chooseUnits(units: units)
//    }
//    
//    public func unitsChangeStateSelected(isSelected: Bool) {
//        // Изменение состояния изображения в зависимости от выбора
//        DispatchQueue.main.async {
//            self.imageView.image = UIImage(named: isSelected == true ? "FullRectangle" : "EmptyRectangle")
//        }
//    }
//}
//
