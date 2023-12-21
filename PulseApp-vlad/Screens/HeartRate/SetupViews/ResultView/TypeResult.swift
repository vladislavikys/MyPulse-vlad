////
////  TypeResult.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//
//class TypeResult: UIView {
//    // Объект изображения, отвечающий за визуализацию результата анализа
//    var image = UIImageView()
//
//    // Замыкание, предоставляющее обновленный тип анализа
//    var updateAnalyze: ((AnalyzeTypes) -> ())?
//
//    // Инициализация вида
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//        
//        // Установка обновления анализа
//        updateAnalyze = { type in
//            DispatchQueue.main.async { [weak self] in
//                self?.updateAnalyzeHandler(type: type)
//            }
//        }
//    }
//
//    // Необходимый инициализатор при использовании Storyboard
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // Настройка интерфейса вида
//    private func setupUI() {
//        // Установка параметров интерфейса вида
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.cornerRadius = 22
//        self.backgroundColor = UIColor(red: 0.945, green: 0.941, blue: 0.961, alpha: 1)
//        self.layer.borderColor = UIColor(red: 0.886, green: 0.878, blue: 0.91, alpha: 1).cgColor
//        self.layer.borderWidth = 1
//        
//        // Добавление изображения на вид
//        self.addSubview(image)
//        
//        // Настройка параметров изображения
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.contentMode = .scaleAspectFit
//        
//        // Активация ограничений для изображения
//        NSLayoutConstraint.activate([
//            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            image.heightAnchor.constraint(equalToConstant: 25),
//            image.widthAnchor.constraint(equalToConstant: 25)
//        ])
//    }
//
//    
//    // Обработчик обновления типа анализа
//    func updateAnalyzeHandler(type: AnalyzeTypes) {
//        switch type {
//        case .coffee:
//            image.image = UIImage(named: "coffee")
//        case .sleep:
//            image.image = UIImage(named: "sleep")
//        case .active:
//            image.image = UIImage(named: "active")
//        default:
//            break
//        }
//    }
//}
//
