//
//  RightNumbersStack.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit

// Класс для отображения вертикального стека меток с определенными числами
class RightNumbersStack: UIStackView {
    
    // Массив чисел, которые будут отображаться в стеке
    private let numbers = ["200", "150", "100", "50", "0"]
    
    // Инициализатор стека
    override init(frame: CGRect) {
        super.init(frame: frame)
        настройкаСтека()
    }
    
    // Инициализатор, требуемый NSCoder (не реализован)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Функция для настройки свойств стека
    private func настройкаСтека() {
        // Установка оси в вертикальное положение
        self.axis = .vertical
        // Установка свойства translatesAutoresizingMaskIntoConstraints в false для использования автоматического макета
        self.translatesAutoresizingMaskIntoConstraints = false
        // Установка распределения fill equally
        self.distribution = .fillEqually
        // Установка расстояния между подпредставлениями
        self.spacing = 10
        
        // Итерация по массиву чисел
        for number in numbers {
            // Создание новой метки
            let label = UILabel()
            // Установка текста метки текущим числом
            label.text = number
            // Установка выравнивания текста в центр
            label.textAlignment = .center
            // Установка цвета текста в черный
            label.textColor = .black
            // Установка шрифта метки с использованием расширения для пользовательского шрифта (предполагается, что вы его определили)
            label.font = .regularFont(size: 12)
            // Добавление метки в стек
            self.addArrangedSubview(label)
        }
    }
}
