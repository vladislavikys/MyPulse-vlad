//
//  ResultStack.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit

// Базовый стек для отображения результата пульса и изображения сердца
class BasicStack: UIStackView {
    var verticalStack: VerticalStack!
    var resultLabel: UILabel!
    
    // Инициализация стека
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStack()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStack()
    }
    
    // Настройка стека для отображения результата пульса и изображения сердца
    private func setupStack() {
        self.axis = .horizontal  // Устанавливаем направление оси стека горизонтальным
        self.spacing = 0         // Устанавливаем расстояние между элементами стека
        self.distribution = .fill // Распределение элементов стека равномерно
        self.translatesAutoresizingMaskIntoConstraints = false  // Отключаем автоматическое создание констрейнтов
        
        // Настраиваем метку для отображения результата пульса
        resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.font = .mediumFont(size: 60)
        resultLabel.text = "00"
        resultLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        self.addArrangedSubview(resultLabel)
        
        // Создаем вертикальный стек для отображения текста "bpm" и изображения сердца
        verticalStack = VerticalStack()
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(verticalStack)
    }


// Вертикальный стек для отображения текста "bpm" и изображения сердца
class VerticalStack: UIStackView {
    var bpmLabel = UILabel()
    var heartImage = UIImageView()
    
    // Инициализация вертикального стека
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupStack()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStack()
    }
    
    // Настройка вертикального стека для отображения текста "bpm" и изображения сердца
    private func setupStack() {
        // Добавляем изображение сердца и метку "bpm" в вертикальный стек
        self.addArrangedSubview(heartImage)
        self.addArrangedSubview(bpmLabel)
        
        // Настраиваем свойства вертикального стека
        self.axis = .vertical  // Устанавливаем направление оси стека вертикальным
        self.spacing = 0        // Устанавливаем расстояние между элементами стека
        self.alignment = .center // Выравниваем элементы стека по центру
        self.distribution = .fill // Распределение элементов стека равномерно
        self.translatesAutoresizingMaskIntoConstraints = false // Отключаем автоматическое создание констрейнтов
        
        // Настраиваем метку "bpm"
        bpmLabel.translatesAutoresizingMaskIntoConstraints = false
        bpmLabel.font = .mediumFont(size: 16)
        bpmLabel.text = "bpm"
        bpmLabel.textColor =  UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        
        // Настраиваем изображение сердца
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        heartImage.image = UIImage(named: "fullHeart")
        heartImage.contentMode = .scaleAspectFit
        heartImage.clipsToBounds = true
        
        // Задаем констрейнты для высоты метки "bpm" и изображения сердца
        NSLayoutConstraint.activate([
            bpmLabel.heightAnchor.constraint(equalToConstant: 25),
            heartImage.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

