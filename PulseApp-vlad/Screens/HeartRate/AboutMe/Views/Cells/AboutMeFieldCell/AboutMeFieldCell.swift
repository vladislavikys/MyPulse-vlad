//
//  AboutMeFieldCell.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit
import QuartzCore

// Финальный класс для ячейки, отображающей различные атрибуты пользователя
final class AboutMeFieldCell: BaseAboutMeCollectionCell {
    
    // Перечисление, представляющее тип поля (например, рост, вес, возраст)
    public var typeField: AboutMeFieldModel = .height
    // Кнопка для добавления данных
    public var addButton: UIButton!
    // Метка для отображения сообщения
    var alertLabel: UILabel!
    // Текстовое поле для ввода пользователем данных
    var alertTextField: UITextField!
    // Жест нажатия для скрытия клавиатуры
    var tapGesture: UITapGestureRecognizer!
    // Вычисляемое свойство, указывающее, не пустое ли текстовое поле
    public var isTextFieldIsNotEmpty: Bool {
        return self.alertTextField.text?.isEmpty == false && self.alertTextField.text != " "
    }
    
    // Переопределение метода для конфигурации пользовательского интерфейса
    override func configUI() {
        super.configUI()
        
        // Создание кнопки
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(UIImage(named: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(showTextField), for: .touchUpInside)
        
        // Создание текстового поля
        alertTextField = UITextField()
        alertTextField.isHidden = true
        alertTextField.translatesAutoresizingMaskIntoConstraints = false
        alertTextField.semanticContentAttribute = .forceRightToLeft
        alertTextField.adjustsFontSizeToFitWidth = true
        alertTextField.textColor = UIColor(red: 0.443, green: 0.4, blue: 0.976, alpha: 1)
        alertTextField.font = .regularFont(size: 17)
        alertTextField.keyboardType = .numberPad
        alertTextField.delegate = self
      
        // Создание метки для отображения предупреждения
        alertLabel = UILabel()
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertLabel.textColor = UIColor(red: 0.886, green: 0.165, blue: 0.275, alpha: 1)
        alertLabel.font = .regularFont(size: 12)
        alertLabel.textAlignment = .left
        alertLabel.isHidden = true
        alertLabel.alpha = 0
    }
    
    // Переопределение метода для настройки макета элементов управления
    override func setupLayout() {
        super.setupLayout()
        
        // Добавление кнопки и текстового поля к ячейке
        self.addSubview(addButton)
        self.addSubview(alertTextField)
        // Добавление метки к стеку заголовка в ячейке
        self.addExternalViewToStackView(view: alertLabel)
        
        // Настройка ограничений
        NSLayoutConstraint.activate([
            self.addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.addButton.heightAnchor.constraint(equalToConstant: 40),
            self.addButton.widthAnchor.constraint(equalToConstant: 40),
            
            self.alertTextField.centerXAnchor.constraint(equalTo: addButton.centerXAnchor),
            self.alertTextField.centerYAnchor.constraint(equalTo: addButton.centerYAnchor),
        ])
    }
    
    // Установка текста на метке предупреждения в соответствии с типом поля
    public func setTextOnAlert(data: AboutMeFieldModel) {
        self.typeField = data
        alertLabel.text = "Please enter a valid value for: \(data.titleText)"
    }
    
    // Изменение изображения кнопки добавления в зависимости от предоставленного имени изображения
    public func changeAddButtonImage(imageName: String) {
        addButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    // Анимация метки предупреждения для визуального предупреждения пользователя
    public func presentAlertLabel() {
        DispatchQueue.main.async {
            self.changeAddButtonImage(imageName: "redAdd")
            UIView.animate(withDuration: 0.5) {
                self.alertLabel.isHidden = false
                self.titleStack.layoutIfNeeded() // Используется для немедленного обновления макета объекта
            } completion: { _ in
                self.presentAlert()
            }
        }
    }
}

// Расширение для реализации протокола UITextFieldDelegate
extension AboutMeFieldCell: UITextFieldDelegate {
    // Ограничение количества символов в текстовом поле до 3
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text else { return false }
        
        let newText = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        return newText.count <= 3
    }
    
    // Метод, вызываемый при завершении редактирования текстового поля
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Показываем кнопку добавления, если текстовое поле пусто
        if alertTextField.text == "" {
            addButton.isHidden = false
        }
    }
    
    // Метод, вызываемый при нажатии кнопки добавления
    @objc private func showTextField() {
        addButton.isHidden = true
        alertTextField.isHidden = false
        alertTextField.becomeFirstResponder()
    }
    
    // Внутренний метод для последовательной анимации метки предупреждения
    func presentAlert() {
        UIView.animate(withDuration: 0.4, delay: 0.1) { [weak self] in
            self?.alertLabel.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 0.8) { [weak self] in
                self?.alertLabel.alpha = 0
            } completion: { _ in
                UIView.animate(withDuration: 0.4) { [weak self] in
                    self?.alertLabel.isHidden = true
                    self?.titleStack.layoutIfNeeded()
                }
            }
        }
    }
}

