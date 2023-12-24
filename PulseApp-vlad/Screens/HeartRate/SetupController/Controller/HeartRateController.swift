//
//  HeartRateController.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import UIKit
import AVFoundation

class HeartRateController: BaseViewController {
    
    var resultStack: BasicStack! // Стек для отображения результатов
    var infoButton = UIButton() // Кнопка информации
    var fingersLabel = UILabel() // Метка для отображения информации о пальцах
    var clueLabel = UILabel() // Метка с подсказкой
    var tutorialImage = UIImageView() // Изображение для обучения
    var crookedLineImage = UIImageView() // Изображение кривой линии
    var scheduleLineImage = UIImageView() // Изображение для отображения графика
    var darkView: UIVisualEffectView? // Темный фон (эффект затемнения)
    var rightNumbers: RightNumbersStack! // Стек для отображения правильных значений
    var progressBar: ProgressBar! // Прогресс-бар
    var startButton = PublicButton() // Кнопка запуска
    
    var reusableView: ReusableAlertView! // Переиспользуемое предупреждение
    var cameraAccess: ReusableAlertView = ReusableAlertView(type: .camera) // Предупреждение о доступе к камере

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.isFirstLaunch() {
            showWelcomeView()
        }
        
        // Скрывает навигационную панель (бар) в текущем контроллере навигации (navigation controller) без анимации.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Устанавливает заголовок экрана "Heart rate".
        titleLabel.text = "Heart rate"
        
        // Вызывает методы для настройки пользовательского интерфейса, прогресс-бара и стека с правильными значениями.
        setupUI()
        setupProgressbar()
        setupRightNumbersStack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Скрывает метку подсказки.
        clueLabel.isHidden = true
        
        // Скрывает изображение для обучения.
        tutorialImage.isHidden = true
        
        // Отображает кнопку запуска измерения.
        startButton.isHidden = false
        
        // Скрывает различные элементы прогресс-бара.
        progressBar.miniProgressLayer.isHidden = true
        progressBar.miniCircleContainerLayer.isHidden = true
        progressBar.shapeLayer.isHidden = true
        
        // Показывает изогнутую линию.
        crookedLineImage.isHidden = false
        
        // Скрывает стек с правильными значениями.
        rightNumbers.isHidden = true
        
        // Скрывает изображение для отображения графика.
        scheduleLineImage.isHidden = true
        
        // Дополнительное скрытие элементов, которые были перечислены в коде дважды (rightNumbers и scheduleLineImage).
        rightNumbers.isHidden = true
        scheduleLineImage.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Вызывает метод для деинициализации сессии захвата, когда контроллер будет скрыт.
        deinitCaptureSession()
    }
    
    
    
    func startPulseAnimation() {
        
    }
    
    func stopPulseAnimation() {
        
    }
    
    func heartBeatAnimation() {
        
    }
    
    func stopHeartBeatAnimation() {
    
    }
    
    private func setupRightNumbersStack() {
        // Initialize and configure the stack for displaying numbers.
        rightNumbers = RightNumbersStack()
        rightNumbers.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightNumbers)
        NSLayoutConstraint.activate([
            rightNumbers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            rightNumbers.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            rightNumbers.heightAnchor.constraint(equalToConstant: 200),
            rightNumbers.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    
    private func setupProgressbar() {
        // Initialize and configure the progress bar.
        progressBar = ProgressBar(frame: CGRect(x: 0, y: 0, width: 220, height: 220))
        view.addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: fingersLabel.topAnchor, constant: 50),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 220),
            progressBar.widthAnchor.constraint(equalToConstant: 220)
        ])
        
        if UserDefaults.isFirstLaunch() {
            print("isFirstLaunch")
        }
    }
    
    
    @objc private func startButtonAction() {
        let aboutMeViewController = AboutMeViewController()
        aboutMeViewController.modalPresentationStyle = .fullScreen
        present(aboutMeViewController, animated: true, completion: nil)
    }

    private func initStartPulse() {
    }
}

// Extension for handling delegates from different screens and views.
extension HeartRateController: AlertViewDelegate {
    
    // Method called when the button is pressed in the privacy view.
    func tappedActionInPrivacyView(forType type: PrivacyType) {
        switch type {
        case .preview:
            // Hide the warning with animation and remove the dark background.
            hideAlertViewWithAnimation()
            self.reusableView.darkView?.removeFromSuperview()
        case .camera:
            print("camera case ")
            
        }
    }

    // Method called after completing the "About Me" stage.
    func completedAboutMeStage() {
        
    }
    
    func closeResultViewAndSaveToDB() {
        
    }
    private func setupUI() {
        // Добавление UI-компонентов на экран.
        view.addSubview(infoButton)
        view.addSubview(fingersLabel)
        view.addSubview(clueLabel)
        view.addSubview(tutorialImage)
        view.addSubview(scheduleLineImage)
        view.addSubview(crookedLineImage)
        view.addSubview(startButton)
        
        // Инициализация и добавление resultStack на экран.
        resultStack = BasicStack()
        resultStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultStack)
        
        // Настройка изображения scheduleLine.
        scheduleLineImage.image = UIImage(named: "scheduleLine")
        scheduleLineImage.translatesAutoresizingMaskIntoConstraints = false
        scheduleLineImage.contentMode = .scaleAspectFit
        
        // Настройка кнопки infoButton.
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.setImage(UIImage(named: "infoButton"), for: .normal)
        
        // Настройка текста и отображения fingersLabel.
        fingersLabel.translatesAutoresizingMaskIntoConstraints = false
        fingersLabel.font = .systemFont(ofSize: 16)
        fingersLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        fingersLabel.text = "No fingers"
        
        // Настройка текста, отображения и выравнивания clueLabel.
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = .systemFont(ofSize: 16)
        clueLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        clueLabel.textAlignment = .center
        clueLabel.numberOfLines = 0
        clueLabel.text = "Place your finger on the back camera and flashlight"
        
        // Настройка изображения tutorialImage.
        tutorialImage.translatesAutoresizingMaskIntoConstraints = false
        tutorialImage.image = UIImage(named: "tutorial")
        
        // Настройка изображения crookedLineImage.
        crookedLineImage.translatesAutoresizingMaskIntoConstraints = false
        crookedLineImage.image = UIImage(named: "crookedLine")
        crookedLineImage.contentMode = .scaleAspectFit
        
        // Настройка кнопки startButton.
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.setTitle("Start", for: .normal)
        startButton.contentMode = .scaleAspectFit
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        // Активация Auto Layout constraints.
        NSLayoutConstraint.activate([
            resultStack.topAnchor.constraint(equalTo: fingersLabel.bottomAnchor, constant: 120),
            resultStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 160),
            
            scheduleLineImage.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 60),
            scheduleLineImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            infoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
            infoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            
            fingersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            fingersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            clueLabel.bottomAnchor.constraint(equalTo: tutorialImage.bottomAnchor, constant: -100),
            clueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            clueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            tutorialImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            
            crookedLineImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            crookedLineImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 68),
            startButton.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}
