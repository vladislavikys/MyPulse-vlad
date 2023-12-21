////
////  ResultScreen.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//
//// Протокол делегата для взаимодействия с результатами
//protocol ResultScreenDelegate {
//    func closeResultViewAndSaveToDB()
//}
//
//class ResultScreen: UIView, ResultViewDelegate {
//    func okTapped() {
//            
//    }
//    
//    
//    // Делегат для взаимодействия с результатами
//    var delegate: ResultScreenDelegate?
//
//    // Вид для отображения результатов
//    var resultView = ResultView()
//
//    // Затемненный фон
//    private var darkView: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .regular)
//        let view = UIVisualEffectView(effect: blurEffect)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    
//    // Инициализация вида
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    // Инициализация из Interface Builder
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    // Вызывается при изменении размеров вида
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        constraints()
//    }
//    
//    // Настройка интерфейса вида
//    private func setupUI() {
//        self.frame = UIScreen.main.bounds
//        self.backgroundColor = .clear
//        resultView.delegateResultView = self
//        
//        self.addSubview(resultView)
//    }
//    
//    // Настройка ограничений
//    private func constraints() {
//        NSLayoutConstraint.activate([
//            darkView.topAnchor.constraint(equalTo: topAnchor),
//            darkView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            darkView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            darkView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            
//            resultView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20),
//            resultView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            resultView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            resultView.heightAnchor.constraint(equalToConstant: 550)
//        ])
//    }
//    
//    // Обновление значений меток
//    func updateLabelsValues(bpm: Int, date: Double, analyzeType: AnalyzeTypes, pulsType: PulseType) {
//        self.resultView.updateCompletion?(bpm, date, analyzeType, pulsType)
//    }
//    
//    // Отображение вида с анимацией
//    func showWithAnimation(in superView: UIView) {
//        // Установка размеров вида равными размерам родительского вида
//        self.frame = superView.bounds
//        self.alpha = 0.0
//        // Начальное положение вида - за пределами экрана внизу
//        self.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
//        
//        // Добавление вида и затемненного фона к родительскому виду
//        superView.addSubview(self)
//        superView.addSubview(darkView)
//        
//        // Анимация отображения вида
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//            self.alpha = 1.0
//            self.transform = .identity
//        }, completion: nil)
//    }
//
//
//// Расширение для реализации методов делегата ResultView
//extension ResultScreen: ResultViewDelegate {
//    
//    // Обработка нажатия на кнопку "OK"
//    func okTapped() {
//        hideWithAnimation()
//        self.darkView.isHidden = true
//    }
//    
//    // Скрытие вида с анимацией
//    private func hideWithAnimation() {
//        // Анимация скрытия вида
//        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//            self.alpha = 0.0
//            // Поднятие вида за пределы экрана внизу
//            self.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
//        }) { _ in
//            // После завершения анимации удаляем вид и вызываем делегат для закрытия результата и сохранения в базу данных
//            self.removeFromSuperview()
//            self.delegate?.closeResultViewAndSaveToDB()
//        }
//    }
//
