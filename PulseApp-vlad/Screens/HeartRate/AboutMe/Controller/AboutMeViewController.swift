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
            if unitsIsSelected == .cmKg {
                cmKgView.unitsChangeStateSelected(isSelected: true)
                cmKgView.changeColor(isSelected: true)
                inLbsView.unitsChangeStateSelected(isSelected: false)
                inLbsView.changeColor(isSelected: false)
            } else {
                cmKgView.unitsChangeStateSelected(isSelected: false)
                cmKgView.changeColor(isSelected: false)
                inLbsView.unitsChangeStateSelected(isSelected: true)
                inLbsView.changeColor(isSelected: true)
            }
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
        // Обработка нажатия кнопки "Continue"
        if !UserDefaults.showAboutMe() {
            // Получение ячеек полей AboutMeFieldCell
            let fieldCells = collectionView.visibleCells.filter { currentCell in
                return currentCell.isKind(of: AboutMeFieldCell.self)
            }
            
            // Фильтрация ячеек, которые не содержат заполненных данных
            let fieldThatHaveNotFilledData = fieldCells.filter { currentCell in
                guard let field = currentCell as? AboutMeFieldCell else { return false }
                return field.isTextFieldIsNotEmpty == false
            }
            
            // Проверка наличия незаполненных ячеек
            if fieldThatHaveNotFilledData.isEmpty {
                // Создание или получение экземпляра пользователя
                let user = UserManager.getUser() ?? UserModel()
                user.units = unitsIsSelected
                
                // Получение видимых ячеек
                let visibleCells = collectionView.visibleCells
                
                // Обработка данных из каждой видимой ячейки
                visibleCells.forEach { currentCell in
                    if let genderCell = currentCell as? GenderCell {
                        // Обработка данных из ячейки GenderCell
                        user.gender = genderCell.genderIsSelected
                        print(genderCell.genderIsSelected)
                    } else if let fieldWithData = currentCell as? AboutMeFieldCell {
                        // Обработка данных из ячейки AboutMeFieldCell
                        let fieldType = fieldWithData.typeField
                        let fieldValue = fieldWithData.alertTextField.text
                        switch fieldType {
                        case .height:
                            user.height = Double(fieldValue ?? "") ?? 0.0
                        case .weight:
                            user.weight = Double(fieldValue ?? "") ?? 0.0
                        case .age:
                            user.age = Int(fieldValue ?? "") ?? 0
                        default:
                            break
                        }
                        print(fieldType)
                        print(fieldValue ?? "")
                    }
                }
                
                // Создание пользователя, если его не существует
                if UserManager.getUser() == nil {
                    UserManager.createUser()
                }
                
                // Запись данных в базу данных Realm
                let realm = try! Realm()
                realm.beginWrite()
                realm.add(user)
                try! realm.commitWrite()
                
                // Закрытие текущего экрана
                if UserManager.getUser() != nil {
                    self.dismiss(animated: true)
                }
                
            } else {
                // Отображение предупреждений для незаполненных ячеек
                fieldThatHaveNotFilledData.forEach { ($0 as? AboutMeFieldCell)?.presentAlertLabel() }
            }
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



