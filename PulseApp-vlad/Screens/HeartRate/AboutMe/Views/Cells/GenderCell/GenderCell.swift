////
////  GenderCell.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//
//// Протокол для обработки выбора поля пола
//protocol GenderCellDelegate: AnyObject {
//    func tapOnChooseGenderField(gender: Gender)
//}
//
//// Финальный класс для ячейки выбора пола в About Me
//final class GenderCell: BaseAboutMeCollectionCell {
//    
//    // Стек для отображения двух полей (мужского и женского)
//    private var gendersStack: UIStackView!
//    // Представление поля для выбора мужского пола
//    private var maleView: GenderFieldView!
//    // Представление поля для выбора женского пола
//    private var femaleView: GenderFieldView!
//    // Текущий выбранный пол
//    public var genderIsSelected: Gender = .male {
//        didSet {
//            // Обновление отображения в зависимости от выбранного пола
//            if genderIsSelected == .male {
//                maleView.changeStateSelected(isSelected: true)
//                maleView.changeColorStateSelected(isSelected: true)
//                femaleView.changeStateSelected(isSelected: false)
//                femaleView.changeColorStateSelected(isSelected: false)
//            } else {
//                maleView.changeStateSelected(isSelected: false)
//                maleView.changeColorStateSelected(isSelected: false)
//                femaleView.changeStateSelected(isSelected: true)
//                femaleView.changeColorStateSelected(isSelected: true)
//            }
//        }
//    }
//    
//    // Настройка пользовательского интерфейса
//    override func configUI() {
//        super.configUI()
//        
//        // Создание стека для отображения двух полей
//        gendersStack = UIStackView()
//        gendersStack.spacing = 14
//        gendersStack.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Создание представления для выбора мужского пола
//        maleView = GenderFieldView(gender: .male)
//        // Создание представления для выбора женского пола
//        femaleView = GenderFieldView(gender: .female)
//        
//        // Назначение делегата для обработки выбора пола
//        maleView.delegate = self
//        femaleView.delegate = self
//        
//        // Установка текста для заголовка (Gender)
//        setTextOnTitle(data: .gender)
//        // Изначально выбран мужской пол
//        genderIsSelected = .male
//    }
//    
//    // Настройка макета
//    override func setupLayout() {
//        super.setupLayout()
//        self.addSubview(gendersStack)
//        self.gendersStack.addArrangedSubview(maleView)
//        self.gendersStack.addArrangedSubview(femaleView)
//        
//        NSLayoutConstraint.activate([
//            self.gendersStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
//            self.gendersStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
//            self.gendersStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
//        ])
//    }
//}
//
//// Расширение для реализации метода делегата GenderCellDelegate
//extension GenderCell: GenderCellDelegate {
//    
//    // Обработка выбора поля пола
//    func tapOnChooseGenderField(gender: Gender) {
//        // Установка выбранного пола и вывод значения в консоль
//        self.genderIsSelected = gender
//        print(gender.rawValue)
//    }
//}
//
