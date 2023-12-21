//
//  ResultHeartRateStack.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit

// Класс для отображения стека с результатом пульса
class ResultHeartRateStack: UIStackView {
    
    // Метка с результатом пульса
    private var resultLabel = UILabel()
    
    // Метка с единицей измерения "bpm"
    private var bpmLabel = VerticalAlignmentLabel()
    
    // Изображение сердца
    private var heartImage = UIImageView()
    
    // Замыкание для обновления значения пульса
    var updateBPM: ((Int) -> ())?
    
    // Инициализатор стека
    override init(frame: CGRect) {
        super.init(frame: frame)
        настройкаИнтерфейса()
        
        // Установка замыкания для обновления значения пульса
        updateBPM = { bpm in
            DispatchQueue.main.async {
                self.resultLabel.text = String(bpm)
            }
        }
    }
    
    // Инициализатор, требуемый NSCoder (не реализован)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Функция для настройки интерфейса
    private func настройкаИнтерфейса() {
        // Добавление подпредставлений в стек
        self.addArrangedSubview(heartImage)
        self.addArrangedSubview(resultLabel)
        self.addArrangedSubview(bpmLabel)
        
        // Установка свойств стека
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFill
        self.distribution = .fill
        self.alignment = .fill
        self.axis = .horizontal
        self.spacing = 2
        
        // Настройка метки с результатом пульса
        resultLabel.text = "00"
        resultLabel.font = .mediumFont(size: 50)
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка метки с единицей измерения "bpm"
        bpmLabel.text = "bpm"
        bpmLabel.textColor = .black
        bpmLabel.contentMode = .bottom
        bpmLabel.font = .mediumFont(size: 16)
        bpmLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка изображения сердца
        heartImage.image = UIImage(named: "fullHeart")
        heartImage.contentMode = .scaleAspectFit
        heartImage.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка ограничений
        constraints()
    }
    
    // Функция для установки ограничений
    private func constraints() {
        NSLayoutConstraint.activate([
            heartImage.centerYAnchor.constraint(equalTo: resultLabel.centerYAnchor),
            heartImage.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}

// Класс метки с вертикальным выравниванием текста
class VerticalAlignmentLabel: UILabel {
    
    // Переопределение метода отрисовки текста
    override func drawText(in rect: CGRect) {
        var newRect = rect
        // Переключатель для режимов вертикального выравнивания
        switch contentMode {
        case .top:
            // Выравнивание текста по верхнему краю
            newRect.size.height = sizeThatFits(rect.size).height
        case .bottom:
            // Вычисление высоты текста и смещение метки
            let height = sizeThatFits(rect.size).height
            newRect.origin.y += rect.size.height - (height + (10))
            newRect.size.height = height
        default:
            break
        }
        // Вызов оригинального метода отрисовки текста с учетом новых параметров
        super.drawText(in: newRect)
    }
}
