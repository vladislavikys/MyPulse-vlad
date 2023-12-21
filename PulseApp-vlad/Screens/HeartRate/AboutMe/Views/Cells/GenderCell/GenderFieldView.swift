////
////  GenderFieldView.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//
//// Финальный класс для представления поля выбора пола
//final class GenderFieldView: UIStackView {
//    
//    // Слабая ссылка на делегата (предположительно, делегат будет контроллером или другим объектом, подписанным на протокол)
//    public weak var delegate: GenderCellDelegate?
//    // Текущий выбранный пол
//    private var gender: Gender
//    // Изображение для отображения состояния выбора (полный или пустой флажок)
//    private var imageView: UIImageView!
//    // Метка для отображения текста (мужской или женский)
//    private var titleLabel: UILabel!
//    
//    // Инициализация объекта
//    init(gender: Gender) {
//        self.gender = gender
//        super.init(frame: .zero)
//        // Настройка пользовательского интерфейса
//        setupUI(titleText: gender.rawValue)
//        // Добавление жеста нажатия на объект
//        tapGesture()
//    }
//    
//    // Необходимый инициализатор, который не используется
//    required init(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // Настройка пользовательского интерфейса
//    private func setupUI(titleText: String) {
//        self.axis = .horizontal
//        self.spacing = 6
//        
//        // Изображение для отображения состояния выбора (полный или пустой флажок)
//        imageView = UIImageView(image: UIImage(named: "emptyCheckBox"))
//        imageView.contentMode = .scaleAspectFit
//        
//        // Метка для отображения текста (мужской или женский)
//        titleLabel = UILabel()
//        titleLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
//        titleLabel.font = .regularFont(size: 16)
//        titleLabel.textAlignment = .center
//        titleLabel.text = titleText
//        
//        // Добавление изображения и метки внутри другого элемента (stack view),
//        // который является контейнером для размещения других элементов.
//        self.addArrangedSubview(imageView)
//        self.addArrangedSubview(titleLabel)
//    }
//    
//    // Добавление жеста нажатия на объект
//    private func tapGesture() {
//        self.isUserInteractionEnabled = true
//        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseGender)))
//    }
//    
//    // Изменение состояния выбора (изображения) в зависимости от параметра isSelected
//    public func changeStateSelected(isSelected: Bool) {
//        DispatchQueue.main.async {
//            self.imageView.image = UIImage(named: isSelected == true ? "fullCheckBox" : "emptyCheckBox")
//        }
//    }
//    
//    // Изменение цвета текста в зависимости от параметра isSelected
//    public func changeColorStateSelected(isSelected: Bool) {
//        self.titleLabel.textColor = UIColor(cgColor: isSelected == true ? .init(red: 0.443, green: 0.4, blue: 0.976, alpha: 1) : .init(red: 0.114, green: 0.114, blue: 0.145, alpha: 1))
//    }
//    
//    // Обработка выбора пола при нажатии на объект
//    @objc private func chooseGender() {
//        delegate?.tapOnChooseGenderField(gender: gender)
//    }
//}
//
