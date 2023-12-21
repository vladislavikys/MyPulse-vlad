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
    var bpm = UILabel() // Метка для отображения ударов в минуту
    var darkView: UIVisualEffectView? // Темный фон (эффект затемнения)
    var userBPMSettings: BPMUserSettings = BPMUserSettings() // Настройки пользователя для BPM
    var rightNumbers: RightNumbersStack! // Стек для отображения правильных значений
    var progressBar: ProgressBar! // Прогресс-бар
    var startButton = PublicButton() // Кнопка запуска
    var reusableView: ReusableAlertView! // Переиспользуемое предупреждение
    var cameraAccess: ReusableAlertView = ReusableAlertView(type: .camera) // Предупреждение о доступе к камере
    var heartViewModel: BindWithHeartControllerProtocol? // Вью-модель для взаимодействия с контроллером сердечного ритма
    var heartRateManager: HeartRateManager! // Менеджер для измерения сердечного ритма
    var measurementStartedFlag = false // Флаг, указывающий на начало измерения
    var bpmForCalculating: [Int] = [] // Массив для хранения значений BPM
    var validFrameCounter = 0 // Счетчик валидных кадров
    var timer = Timer() // Таймер
    var timerTwo = Timer() // Второй таймер

    // Алгоритм обнаружения пульса
    var pulseDetector = PulseDetector() // Детектор пульса
    var inputs: [CGFloat] = [] // Входные данные для алгоритма
    var hueFilter = Filter() // Фильтр для обработки цветовых оттенков

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Скрывает навигационную панель (бар) в текущем контроллере навигации (navigation controller) без анимации.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Устанавливает заголовок экрана "Heart rate".
        titleLabel.text = "Heart rate"
        
        // Вызывает методы для настройки пользовательского интерфейса, прогресс-бара и стека с правильными значениями.
        setupUI()
        setupProgressbar()
        setupRightNumbersStack()
        
        // Создает экземпляр вью-модели для контроллера сердечного ритма.
        heartViewModel = HeartRateViewModel()
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
        
        // Скрывает метку для отображения ударов в минуту.
        bpm.isHidden = true
        
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
    
    private func setupUI() {
        // Добавление UI-компонентов на экран.
        view.addSubview(infoButton)
        view.addSubview(fingersLabel)
        view.addSubview(clueLabel)
        view.addSubview(tutorialImage)
        view.addSubview(scheduleLineImage)
        view.addSubview(crookedLineImage)
        view.addSubview(startButton)
        view.addSubview(bpm)
        
        // Инициализация и добавление resultStack на экран.
        resultStack = BasicStack()
        resultStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultStack)
        
        // Настройка изображения scheduleLine.
        scheduleLineImage.image = UIImage(named: "scheduleLine")
        scheduleLineImage.translatesAutoresizingMaskIntoConstraints = false
        scheduleLineImage.contentMode = .scaleAspectFit
        
        // Настройка текста и отображения bpm.
        bpm.text = "bpm"
        bpm.translatesAutoresizingMaskIntoConstraints = false
        bpm.font = .regularFont(size: 10)
        bpm.textColor = .black
        
        // Настройка кнопки infoButton.
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.setImage(UIImage(named: "infoButton"), for: .normal)
        
        // Настройка текста и отображения fingersLabel.
        fingersLabel.translatesAutoresizingMaskIntoConstraints = false
        fingersLabel.font = .regularFont(size: 16)
        fingersLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        fingersLabel.text = "No fingers"
        
        // Настройка текста, отображения и выравнивания clueLabel.
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = .regularFont(size: 16)
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
            resultStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140),
            
            scheduleLineImage.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 60),
            scheduleLineImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
            bpm.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
            bpm.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
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

        
    func startPulseAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Отображение компонентов интерфейса для анимации пульса.
            self.rightNumbers.isHidden = false
            self.clueLabel.text = "Testing, keep your finger steady"
            self.clueLabel.isHidden = false
            self.tutorialImage.isHidden = true
            self.bpm.isHidden = false
            self.scheduleLineImage.isHidden = false
            self.progressBar.miniProgressLayer.isHidden = false
            self.progressBar.miniCircleContainerLayer.isHidden = false
            self.progressBar.shapeLayer.isHidden = false
            self.startButton.isHidden = true
            self.crookedLineImage.isHidden = true
        }
    }

    
    func stopPulseAnimation() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Остановка анимации пульса и сокрытие соответствующих компонентов интерфейса.
            self.rightNumbers.isHidden = true
            self.clueLabel.text = "Place your finger on the back camera and flashlight"
            self.clueLabel.isHidden = false
            self.tutorialImage.isHidden = false
            self.bpm.isHidden = true
            self.scheduleLineImage.isHidden = true
            self.startButton.isHidden = true
            self.crookedLineImage.isHidden = true
        }
    }

    func heartBeatAnimation() {
        // Создание анимации пульса с использованием CASpringAnimation.
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 1.0
        pulse.toValue = 1.12
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 0.8
        
        DispatchQueue.main.async { [weak self] in
            // Добавление анимации к изображению сердца.
            self?.resultStack.verticalStack.heartImage.layer.add(pulse, forKey: nil)
        }
    }

    
    func stopHeartBeatAnimation() {
        DispatchQueue.main.async { [weak self] in
            // Остановка анимации пульса для изображения сердца.
            self?.resultStack.verticalStack.heartImage.subviews.forEach { $0.layer.removeAllAnimations() }
            self?.resultStack.verticalStack.heartImage.layer.removeAllAnimations()
            self?.resultStack.verticalStack.heartImage.layoutIfNeeded()
        }
    }

    private func setupRightNumbersStack() {
        // Инициализация и настройка стека для отображения чисел.
        rightNumbers = RightNumbersStack()
        rightNumbers.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightNumbers)
        constraintsForRightNumbersStack()
    }

    private func constraintsForRightNumbersStack() {
        // Установка ограничений для стека справа.
        NSLayoutConstraint.activate([
            rightNumbers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            rightNumbers.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            rightNumbers.heightAnchor.constraint(equalToConstant: 200),
            rightNumbers.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupProgressbar() {
        // Инициализация и настройка полосы прогресса.
        progressBar = ProgressBar(frame: CGRect(x: 0, y: 0, width: 220, height: 220))
        view.addSubview(progressBar)
        constraintsForProgressBar()
        
        if UserDefaults.isFirstLaunch() {
            showWelcomeView()
        }
    }

    
    private func constraintsForProgressBar() {
        // Установка ограничений для полосы прогресса.
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: fingersLabel.topAnchor, constant: 50),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 220),
            progressBar.widthAnchor.constraint(equalToConstant: 220)
        ])
    }

    @objc private func startButtonAction() {
        // Обработчик нажатия на кнопку "Start".
        self.startPulsHeartRate()
    }

    private func startPulsHeartRate() {
        // Запуск процесса измерения пульса.

        if UserDefaults.showAboutMe() {
            heartViewModel?.showAboutMeViewController(heartController: self)
        } else {
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == AVAuthorizationStatus.authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.initStartPulse()
                }
            } else {
                self.completedAboutMeStage()
            }
        }
    }

    
    private func initStartPulse() {
        // Инициализация захвата видео и сессии измерения пульса.
        initVideoCapture()
        initCaptureSession()
    }


    // Расширение (extension) для обработки делегатов из различных экранов и представлений.
    extension HeartRateController: AlertViewDelegate, TypesDelegate, ResultScreenDelegate {

        // Метод, вызываемый при нажатии на кнопку в представлении конфиденциальности.
        func tappedActionInPrivacyView(forType type: PrivacyType) {
            switch type {
            case .preview:
                // Скрыть предупреждение с анимацией и удалить затемненный фон.
                hideAlertViewWithAnimation()
                self.reusableView.darkView?.removeFromSuperview()
            case .camera:
                // Скрыть предупреждение с анимацией и удалить затемненный фон.
                hideAlertViewWithAnimation()
                self.reusableView.darkView?.removeFromSuperview()
                
                // Запрос доступа к камере и обработка ответа.
                AVCaptureDevice.requestAccess(for: AVMediaType.video) { [unowned self] response in
                    if response {
                        // В случае получения доступа к камере выполнить следующие действия.
                        DispatchQueue.main.async {
                            self.fingersLabel.isHidden = false
                            self.startButton.isHidden = true
                            self.tutorialImage.isHidden = false
                            self.scheduleLineImage.isHidden = true
                            self.crookedLineImage.isHidden = true
                            self.clueLabel.isHidden = false
                        }
                        self.initStartPulse()
                    }
                }
            }
        }

        // Метод, вызываемый после завершения этапа "About Me".
        func completedAboutMeStage() {
            if UserDefaults.showCameraAccess() {
                // Показать представление доступа к камере.
                showCameraAccessView()
            } else {
                // Показать предупреждение о отсутствии доступа к камере.
                let alert = UIAlertController(title: NSLocalizedString("No access to camera", comment: ""),
                                              message: NSLocalizedString("please allow access to the camera", comment: ""),
                                              preferredStyle: .alert)
                
                let actionOK = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil)
                alert.addAction(actionOK)
                self.present(alert, animated: true, completion: nil)
            }
        }

        // Метод, вызываемый после окончательного определения типа (например, сердечный ритм).
        func finalDefinitionType(types: AnalyzeTypes) {
            // Обработать определенный тип и показать результат.
            heartViewModel?.handleAnalyzeType(type: types)
            heartViewModel?.showResultView(heartController: self)
        }

        // Метод, вызываемый после закрытия экрана с результатами и сохранения данных в базу данных.
        func closeResultViewAndSaveToDB() {
            // Сохранить настройки пульса в базу данных и показать вкладку таббара.
            heartViewModel?.saveBPMSettingsToDB()
            tabBarController?.tabBar.isHidden = false
        }
    }
