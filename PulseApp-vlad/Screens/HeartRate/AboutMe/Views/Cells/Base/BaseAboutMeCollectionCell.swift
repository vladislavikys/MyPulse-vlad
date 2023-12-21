//
//  BaseAboutMeCollectionCell.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit

// Базовый класс для ячейки коллекции в разделе About Me
class BaseAboutMeCollectionCell: UICollectionViewCell {
    
    // Заголовок ячейки
    private var titleLabel: UILabel!
    // Стек для отображения заголовка и других представлений
    public var titleStack: UIStackView!
    
    // Инициализатор, вызывающий методы настройки интерфейса и макета
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setupLayout()
    }
    
    // Не реализованный инициализатор из-за необходимости реализации инициализатора NSCoder
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка пользовательского интерфейса
    public func configUI(){
        // Установка стилей границы и цвета фона
        layer.borderWidth = 1
        layer.borderColor =  UIColor(red: 0.921, green: 0.914, blue: 0.943, alpha: 1).cgColor
        backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.976, alpha: 0.35)
        layer.cornerRadius = 15
        
        // Создание стека для отображения заголовка и других представлений
        titleStack = UIStackView()
        titleStack.axis = .vertical
        titleStack.spacing = 5
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Создание метки для отображения заголовка
        titleLabel = UILabel()
        titleLabel.font = .regularFont(size: 18)
        titleLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
    }
    
    // Настройка макета
    public func setupLayout(){
        titleStack.addArrangedSubview(titleLabel) // добавляем метку в вертикальный стек
        self.addSubview(titleStack) // добавляем вертикальный стек (titleStack) в текущее представление self
        
        // Установка ограничений для стека заголовка
        NSLayoutConstraint.activate([
            self.titleStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            self.titleStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // Установка текста для заголовка
    public func setTextOnTitle(data: AboutMeFieldModel){
        self.titleLabel.text = data.titleText
    }
    
    // Добавление внешнего представления в стек
    public func addExternalViewToStackView(view: UIView){
        self.titleStack.addArrangedSubview(view)
    }
}

