////
////  ResultView.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//
//// Протокол делегата для обработки нажатия кнопки "Ok"
//protocol ResultViewDelegate: AnyObject {
//    func okTapped()
//}
//
//class ResultView: UIView {
//    
//    // Перечисление для различных типов меток в результате
//    enum LabelType {
//        case date, title, heartTitle, description
//    }
//    
//    // Слабая ссылка на делегата
//    weak var delegateResultView: ResultViewDelegate?
//    
//    // Массив типов меток в результате
//    var labelsType: [LabelType] = [.date, .heartTitle, .title, .description]
//    
//    // Метки для отображения различных данных
//    var date: UILabel!
//    var heartTitle: UILabel!
//    var title: UILabel!
//    var descriptionLabel: UILabel!
//    
//    // Стек для отображения пульса
//    var heartRateStack: ResultHeartRateStack!
//    
//    // Вид для отображения типа результата (какие типы анализа были выполнены)
//    var typeResult: TypeResult!
//    
//    // Вид для отображения типа пульса (например, "нормальный" или другой)
//    var pulsTypeView = PulsTypeView(pulsType: .normal)
//    
//    // Кнопка "Ok" с использованием кастомного стиля
//    var okButton: PublicButton! {
//        didSet {
//            okButton.setTitle("Ok", for: .normal)
//            okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
//        }
//    }
//    
//    // Замыкание для обновления данных при появлении результата
//    var updateCompletion: ((_ bpm: Int, _ date: Double, _ analyzeType: AnalyzeTypes, _ pulseType: PulseType) -> ())?
//    
//    // Инициализатор вида
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        
//        // Привязываем замыкание для обновления данных
//        updateCompletion = { bpm, date, analyze, type in
//            // Вызываем методы обновления соответствующих компонентов
//            self.heartRateStack.updateBPM?(bpm)
//            self.date.text = self.dateFormat(dateInterval: date)
//            self.typeResult.updateAnalyze?(analyze)
//            self.pulsTypeView.updateTypePulse(type: type)
//        }
//    }
//    
//    // Заглушка для реализации требования инициализатора
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // Обработка изменения размеров вида
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        constraints()
//    }
//    
//    // Настройка пользовательского интерфейса
//    private func setupUI() {
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.backgroundColor = .white
//        self.layer.cornerRadius = 30
//        
//        // Настройка текстовых меток
//        setupTextLabels()
//        
//        // Инициализация компонентов вида
//        heartRateStack = ResultHeartRateStack()
//        typeResult = TypeResult()
//        okButton = PublicButton()
//      
//        // Добавление компонентов на вида
//        self.addSubview(okButton)
//        self.addSubview(typeResult)
//        self.addSubview(heartRateStack)
//        self.addSubview(pulsTypeView)
//    }
//    
//    // Настройка текстовых меток
//    private func setupTextLabels() {
//        date = groupLabels(type: .date)
//        title = groupLabels(type: .title)
//        heartTitle = groupLabels(type: .heartTitle)
//        descriptionLabel = groupLabels(type: .description)
//    }
//
//    // Форматирование даты для отображения
//    private func dateFormat(dateInterval: Double) -> String {
//        let date = Date(timeIntervalSince1970: dateInterval)
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = " MMMM dd yyyy h:mm a "
//        formatter.amSymbol = "AM"
//        formatter.pmSymbol = "PM"
//        let dateString = formatter.string(from: date)
//        return dateString
//    }
//    
//    // Создание текстовой метки в зависимости от типа
//    private func groupLabels(type: LabelType) -> UILabel {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        switch type {
//        case .date:
//            label.text = "November 24 2023, 17:00 AM"
//            label.font = .regularFont(size: 12)
//            label.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 0.3)
//            constraintsForLabels(label: label, type: .date)
//        case .title:
//            label.text = "Result"
//            label.font = .regularFont(size: 20)
//            label.textAlignment = .center
//            label.textColor = .black
//            constraintsForLabels(label: label, type: .title)
//        case .heartTitle:
//            label.text = "Heart Rate Tips"
//            label.font = .mediumFont(size: 20)
//            label.textColor = .black
//            label.textAlignment = .left
//            constraintsForLabels(label: label, type: .heartTitle)
//        case .description:
//            label.text = "Many lifestyle habits can maintain a healthy heart rate, and a healthy diet helps to keep your heart rate slow for a long time. Eat more vegetables and fruits, and eat less foods high in fat and cholesterol."
//            label.font = .regularFont(size: 16)
//            label.textColor = .black
//            label.numberOfLines = 0
//            constraintsForLabels(label: label, type: .description)
//        }
//        return label
//    }
//    
//    // Настройка ограничений для компонентов вида
//    private func constraints() {
//        NSLayoutConstraint.activate([
//            okButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
//            okButton.centerXAnchor.constraint(equalTo: centerXAnchor),
//            okButton.heightAnchor.constraint(equalToConstant: 68),
//            okButton.widthAnchor.constraint(equalToConstant: 300),
//            
//            heartRateStack.topAnchor.constraint(equalTo: date.topAnchor, constant: 20),
//            heartRateStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
//            heartRateStack.heightAnchor.constraint(equalToConstant: 60),
//            
//            typeResult.topAnchor.constraint(equalTo: topAnchor, constant: 60),
//            typeResult.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
//            typeResult.widthAnchor.constraint(equalToConstant: 55),
//            typeResult.heightAnchor.constraint(equalToConstant: 55),
//            
//            pulsTypeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
//            pulsTypeView.topAnchor.constraint(equalTo: heartRateStack.bottomAnchor, constant: 5),
//            pulsTypeView.widthAnchor.constraint(equalToConstant: 110),
//            pulsTypeView.heightAnchor.constraint(equalToConstant: 31)
//        ])
//    }
//    
//    // Настройка ограничений для текстовых меток
//    private func constraintsForLabels(label: UILabel, type: LabelType) {
//        self.addSubview(label)
//        switch type {
//        case .date:
//            NSLayoutConstraint.activate([
//                label.topAnchor.constraint(equalTo: topAnchor, constant: 70),
//                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
//            ])
//        case .title:
//            NSLayoutConstraint.activate([
//                label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//                label.centerXAnchor.constraint(equalTo: centerXAnchor)
//            ])
//        case .heartTitle:
//            NSLayoutConstraint.activate([
//                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
//                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -330)
//            ])
//        case .description:
//            NSLayoutConstraint.activate([
//                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
//                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
//                label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -240)
//            ])
//        }
//    }
//    
//    // Обработчик нажатия на кнопку "Ok"
//    @objc private func okButtonTapped() {
//        delegateResultView?.okTapped()
//    }
//}
//
