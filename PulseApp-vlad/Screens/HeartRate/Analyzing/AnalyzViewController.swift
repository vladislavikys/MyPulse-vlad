////
////  AnalyzViewController.swift
////  PulseApp-vlad
////
////  Created by Влад on 21.12.23.
////
//
//import Foundation
//import UIKit
//
//// Протокол для делегата, который будет оповещен о выборе типа анализа
//protocol TypesDelegate: AnyObject{
//    func finalDefinitionType(types: AnalyzeTypes)
//}
//
//class AnalyzViewController: BaseViewController{
//    
//    // Слабая ссылка на делегата типов анализа
//    weak var delegate: TypesDelegate?
//    
//    // Кнопка "Continue"
//    private var button = PublicButton()
//    
//    // Метка с описанием
//    private var label = UILabel()
//    
//    // Стек представлений с типами анализа
//    private var stackView: UIStackView!
//    
//    // Представление для отдыха
//    private var restingTypesView: TypesView!
//    
//    // Представление для сна
//    private var sleepTypesView: TypesView!
//    
//    // Представление для активности
//    private var activeTypesView: TypesView!
//    
//    // Выбранный тип анализа
//    private var typesIsSelected: AnalyzeTypes = .coffee {
//        didSet {
//            // Обновление визуального состояния представлений в зависимости от выбранного типа
//            if typesIsSelected == .coffee {
//                restingTypesView.typesChangeStateSelected(isSelected: true)
//                restingTypesView.changeTypesLabelColor(isSelected: true)
//                sleepTypesView.typesChangeStateSelected(isSelected: false)
//                sleepTypesView.changeTypesLabelColor(isSelected: false)
//                activeTypesView.typesChangeStateSelected(isSelected: false)
//                activeTypesView.changeTypesLabelColor(isSelected: false)
//            } else if typesIsSelected == .sleep {
//                restingTypesView.typesChangeStateSelected(isSelected: false)
//                restingTypesView.changeTypesLabelColor(isSelected: false)
//                sleepTypesView.typesChangeStateSelected(isSelected: true)
//                sleepTypesView.changeTypesLabelColor(isSelected: true)
//                activeTypesView.typesChangeStateSelected(isSelected: false)
//                activeTypesView.changeTypesLabelColor(isSelected: false)
//            } else if typesIsSelected == .active {
//                restingTypesView.typesChangeStateSelected(isSelected: false)
//                restingTypesView.changeTypesLabelColor(isSelected: false)
//                sleepTypesView.typesChangeStateSelected(isSelected: false)
//                sleepTypesView.changeTypesLabelColor(isSelected: false)
//                activeTypesView.typesChangeStateSelected(isSelected: true)
//                activeTypesView.changeTypesLabelColor(isSelected: true)
//            }
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Установка заголовка
//        titleLabel.text = "Analyzing"
//        
//        // Настройка пользовательского интерфейса
//        setupUI()
//        
//        // Конфигурация стека представлений
//        configStackView()
//        
//        // Установка макета для стека представлений
//        setupLayoutStackView()
//    }
//    
//    // Конфигурация стека представлений
//    private func configStackView() {
//        stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.spacing = 35
//        stackView.distribution = .fillEqually
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Инициализация представлений с типами анализа
//        restingTypesView = TypesView(types: .coffee, images: UIImageView(image: UIImage(named: "coffee")))
//        sleepTypesView = TypesView(types: .sleep, images: UIImageView(image: UIImage(named: "sleep")))
//        activeTypesView = TypesView(types: .active, images: UIImageView(image: UIImage(named: "active")))
//        
//        // Установка делегатов
//        restingTypesView.typesDelegate = self
//        sleepTypesView.typesDelegate = self
//        activeTypesView.typesDelegate = self
//        
//        // Установка начального выбранного типа
//        typesIsSelected = .coffee
//    }
//    
//    // Установка макета для стека представлений
//    private func setupLayoutStackView() {
//        view.addSubview(stackView)
//        stackView.addArrangedSubview(restingTypesView)
//        stackView.addArrangedSubview(sleepTypesView)
//        stackView.addArrangedSubview(activeTypesView)
//        
//        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
//    // Настройка пользовательского интерфейса
//    private func setupUI() {
//        view.addSubview(button)
//        view.addSubview(label)
//       
//        // Установка параметров кнопки
//        button.setTitle("Continue", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(dismissAnalyze), for: .touchUpInside)
//      
//        // Настройка метки с описанием
//        label.font = .regularFont(size: 16)
//        label.textColor = .black
//        label.numberOfLines = 0
//        label.text = "People have different heart rates in different states, Selecting the current state will effectively provide you with heart rate assessment analysis"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75),
//            button.heightAnchor.constraint(equalToConstant: 68),
//            button.widthAnchor.constraint(equalToConstant: 300),
//            
//            label.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 55),
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
//            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
//        ])
//    }
//    
//    // Обработчик нажатия на кнопку "Continue"
//    @objc private func dismissAnalyze() {
//        // Уведомление делегата о выбранном типе анализа и закрытие текущего экрана
//        self.delegate?.finalDefinitionType(types: typesIsSelected)
//        self.dismiss(animated: true)
//    }
//}
//
//// Реализация делегата для выбора типа анализа
//extension AnalyzViewController: TypesDelegate {
//    func finalDefinitionType(types: AnalyzeTypes) {
//        self.typesIsSelected = types
//    }
//}
//
