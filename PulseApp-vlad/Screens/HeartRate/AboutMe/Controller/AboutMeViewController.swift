//
//  AboutMeViewController.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import UIKit

// Протокол для обработки выбора единиц измерения
protocol UnitsDelegate: AnyObject {
    func chooseUnits(units: Units)
}

class AboutMeViewController: BaseViewController {
    
    // Массив моделей для полей About Me
    var attributes = [AboutMeFieldModel.height, .weight, .age]
    private var stackView: UIStackView!
    private var cmKgView: UnitsView!
    private var inLbsView: UnitsView!
    private var continueButton = PublicButton()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private var unitsIsSelected: Units = .cmKg {
        didSet {
            // Обновление визуального состояния кнопок выбора единиц измерения
            cmKgView.unitsChangeStateSelected(isSelected: unitsIsSelected == .cmKg)
            cmKgView.changeColor(isSelected: unitsIsSelected == .cmKg)

            inLbsView.unitsChangeStateSelected(isSelected: unitsIsSelected == .inLbs)
            inLbsView.changeColor(isSelected: unitsIsSelected == .inLbs)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установка заголовка экрана
        titleLabel.text = "About me"
        
        // Регистрация ячеек для коллекции
        collectionView.register(GenderCell.self, forCellWithReuseIdentifier: "GenderCell")
        collectionView.register(AboutMeFieldCell.self, forCellWithReuseIdentifier: "AboutMeFieldCell")
        
        // Настройка источников данных и делегата коллекции
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Настройка пользовательского интерфейса
        setupUI()
        
        // Конфигурация стека и размещение его в представлении
        configStackView()
        setupLayout()
    }
    
    
    private func configStackView() {
        // Настройка стекового представления для кнопок выбора единиц измерения
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        cmKgView = UnitsView(units: .cmKg)
        inLbsView = UnitsView(units: .inLbs)
        
        // Настройка делегатов для кнопок выбора единиц измерения
        cmKgView.unitsDelegate = self
        inLbsView.unitsDelegate = self
        
        unitsIsSelected = .cmKg
    }
    
    private func setupLayout() {
        // Настройка размещения стекового представления
        view.addSubview(stackView)
        stackView.addArrangedSubview(cmKgView)
        stackView.addArrangedSubview(inLbsView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 80),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 85),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -85),
        ])
    }
    
    private func setupUI() {
        // Настройка внешнего вида кнопки "Continue"
        continueButton.setTitle("Continue", for: .normal)
        continueButton.addTarget(self, action: #selector(actionContinueButton), for: .touchUpInside)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        // Добавление элементов на экран
        view.addSubview(continueButton)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75),
            continueButton.heightAnchor.constraint(equalToConstant: 68),
            continueButton.widthAnchor.constraint(equalToConstant: 300),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 90),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
        ])
    }
    
    @objc func actionContinueButton() {
        // Возвращаемся на предыдущий экран (если он существует в стеке)
        dismiss(animated: true)
    }
}


// Реализация методов протоколов UICollectionViewDelegateFlowLayout и UICollectionViewDataSource

extension AboutMeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // Метод определяет количество ячеек в секции коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attributes.count + 1 // Количество атрибутов плюс одна дополнительная ячейка для выбора пола
    }
    
    // Метод настраивает и возвращает ячейку для отображения в коллекции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            // Если это первая ячейка, то вернуть ячейку выбора пола
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenderCell", for: indexPath) as! GenderCell
            return cell
        } else {
            // В противном случае вернуть ячейку с атрибутом (рост, вес, возраст)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutMeFieldCell", for: indexPath) as! AboutMeFieldCell
            cell.setTextOnTitle(data: attributes[indexPath.row - 1]) // -1 для исключения первой строки
            cell.setTextOnAlert(data: attributes[indexPath.row - 1])
            return cell
        }
    }
    
    // Метод определяет размер ячейки в коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 36, height: 60)
    }
}

// Реализация метода протокола UnitsDelegate для обработки выбора единиц измерения

extension AboutMeViewController: UnitsDelegate {
    
    // Метод протокола, вызываемый при выборе единиц измерения
    func chooseUnits(units: Units) {
        self.unitsIsSelected = units
    }
}



