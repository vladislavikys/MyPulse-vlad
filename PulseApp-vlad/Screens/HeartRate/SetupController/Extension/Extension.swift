//
//  Extension.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit
import AVKit

extension HeartRateController {
    
    // MARK: - Video Capture Initialization
    
    // Иллюстрирует инициализацию захвата видео с камеры устройства.
    // Создает объект HeartRateManager с заданными параметрами
    // и устанавливает обработчика изображений для каждого кадра видео.
    func initVideoCapture() {
        let specs = VideoSpec(fps: 60, size: CGSize(width: 50, height: 50))
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs, previewContainer: CAShapeLayer())
        heartRateManager?.imageBufferHandler = { [unowned self] (imageBuffer) in
            self.handle(buffer: imageBuffer)
        }
    }
    
    // MARK: - Capture Session
    
    // Инициализирует и запускает захват видео.
    func initCaptureSession() {
        heartRateManager?.startCapture()
    }
    
    // Деинициализирует захват видео, останавливает видео и выключает вспышку.
    func deinitCaptureSession() {
        if heartRateManager != nil {
            heartRateManager.stopCapture()
            toggleTorch(status: false)
        }
    }
    
    // MARK: - Torch Control
    
    // Включает или выключает вспышку на устройстве для освещения съемки видео.
    func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(on: status)
    }
    
    // MARK: - Measurement
    
    // Запускает измерение пульса.
    func startMeasurement() {
        DispatchQueue.main.async {
            // Очищает массив данных о пульсе для вычислений.
            self.bpmForCalculating.removeAll()
            // Включает вспышку.
            self.toggleTorch(status: true)
            // Запускает анимацию пульса.
            self.startPulseAnimation()
            // Запускает анимацию прогресса с длительностью 20 секунд.
            self.progressBar.animation(duration: 20)
            // Устанавливает начальное значение счетчика времени в 20 секунд.
            var count = 20
            
            // Создает таймер, который будет запускаться каждую секунду и выполнять блок кода.
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
                guard let self = self else { return }
                
                if count > 0 {
                    // Уменьшает счетчик времени.
                    count -= 1
                    // Запускает анимацию сердечного ритма.
                    self.heartBeatAnimation()
                    // Обновляет метку с информацией о времени до завершения измерения.
                    self.fingersLabel.text = "\(count) " + NSLocalizedString("seconds remaining", comment: "")
                    
                    // Получает среднее значение для вычисления пульса.
                    let average = self.pulseDetector.getAverage()
                    let pulse = 60.0 / average
                    print("pulse: \(pulse)")
                    
                    // Проверяет, что значение пульса не является исключительным значением.
                    if pulse != -60 {
                        // Обновляет метку результата с текущим значением пульса.
                        self.resultStack.resultLabel.text = "\(lroundf(pulse))"
                        // Добавляет значение пульса в массив для вычислений.
                        self.bpmForCalculating.append(Int(pulse))
                    }
                } else {
                    // Если массив с данными о пульсе не пуст, вычисляет и сохраняет данные в базу данных.
                    if !self.bpmForCalculating.isEmpty {
                        self.heartViewModel?.calculateAndSaveBPMDataToDB(pulse: self.bpmForCalculating)
                        // Переходит к экрану анализа.
                        self.heartViewModel?.showAnalyzeVC(heartController: self)
                    }
                    // Возвращает интерфейс в начальное состояние.
                    self.defaultState()
                }
            })
        }
    }

    
    // Восстанавливает начальное состояние элементов интерфейса.
    func defaultState() {
        // Скрывает метку с информацией о пальцах.
        fingersLabel.isHidden = true
        // Устанавливает текст метки "No Fingers".
        fingersLabel.text = "No Fingers"
        // Отображает изображение кривой линии.
        crookedLineImage.isHidden = false
        // Скрывает изображение с подсказкой.
        tutorialImage.isHidden = true
        // Отображает кнопку запуска измерения.
        self.startButton.isHidden = false
        // Устанавливает текст метки результата в "00".
        self.resultStack.resultLabel.text = "00"
        // Скрывает метку-подсказку.
        clueLabel.isHidden = true
        // Выключает вспышку.
        self.toggleTorch(status: false)
        // Удаляет анимацию прогресса.
        self.progressBar.deleteAnimation()
        // Останавливает захват видео.
        self.heartRateManager?.stopCapture()
        // Останавливает анимацию пульса.
        self.stopHeartBeatAnimation()
        // Скрывает изображение линии графика расписания.
        self.scheduleLineImage.isHidden = true
        // Скрывает мини-прогресс и контейнер мини-круга прогресса.
        progressBar.miniProgressLayer.isHidden = true
        progressBar.miniCircleContainerLayer.isHidden = true
        // Отменяет таймер.
        timer.invalidate()
    }

    
    // MARK: - Image Buffer Handling
    
    // Обрабатывает изображение из видеобуфера.
    func handle(buffer: CMSampleBuffer) {
        // Инициализация переменных для хранения средних значений цветов пикселей.
        var redmean: CGFloat = 0.0
        var greenmean: CGFloat = 0.0
        var bluemean: CGFloat = 0.0
        
        // Получение изображения из видеобуфера.
        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)
        
        // Вычисление средних значений цветов с использованием фильтра CIAreaAverage.
        let extent = cameraImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let averageFilter = CIFilter(name: "CIAreaAverage",
                                     parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent])!
        let outputImage = averageFilter.outputImage!
        
        // Создание CGImage из выходного изображения фильтра.
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(outputImage, from: outputImage.extent)!
        
        // Получение необработанных данных из CGImage.
        let rawData: NSData = cgImage.dataProvider!.data!
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start: pixels, count: rawData.length)
        var BGRA_index = 0
        
        // Итерация по байтам, представляющим компоненты BGRA цвета.
        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
            switch BGRA_index {
            case 0:
                bluemean = CGFloat(pixel)
            case 1:
                greenmean = CGFloat(pixel)
            case 2:
                redmean = CGFloat(pixel)
            case 3:
                break
            default:
                break
            }
            BGRA_index += 1
        }
        
        // Преобразование RGB цвета в HSV цвет.
        let hsv = rgb2hsv((red: redmean, green: greenmean, blue: bluemean, alpha: 1.0))
        
        // Проверка, что цвет пикселя соответствует пальцу (наличие яркости и насыщенности).
        if (hsv.1 > 0.5 && hsv.2 > 0.5) {
            // Выполнение действий на главной очереди.
            DispatchQueue.main.async {
                // Включение вспышки и запуск измерения при наличии пальца.
                self.toggleTorch(status: true)
                if !self.measurementStartedFlag {
                    self.startMeasurement()
                    self.measurementStartedFlag = true
                }
            }
            // Увеличение счетчика валидных кадров.
            validFrameCounter += 1
            // Добавление значения оттенка в массив входных данных.
            inputs.append(hsv.0)
            
            // Фильтрация значения оттенка с помощью фильтра полосовой полосы.
            let filtered = hueFilter.processValue(value: Double(hsv.0))
            // Добавление нового значения в детектор пульса после 60 валидных кадров.
            if validFrameCounter > 60 {
                _ = self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
            }
        } else {
            // Если цвет не соответствует пальцу, остановка измерения и сброс детектора пульса.
            self.timer.invalidate()
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            
            // Выполнение действий на главной очереди.
            DispatchQueue.main.async {
                // Остановка анимации пульса и сердечного ритма, обновление меток.
                self.stopPulseAnimation()
                self.stopHeartBeatAnimation()
                self.fingersLabel.text = NSLocalizedString("No fingers", comment: "")
                self.resultStack.resultLabel.text = "00"
                self.progressBar.deleteAnimation()
            }
        }
    }

    
    // MARK: - UI Presentation
    
    // Показывает представление приветствия.
    func showWelcomeView() {
        // Настраивает затемненный фон.
        setupDarkView()
        
        // Создает экземпляр ReusableAlertView типа .preview.
        reusableView = ReusableAlertView(type: .preview)
        reusableView.delegate = self
        reusableView.darkView = self.darkView
        reusableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляет представление к основному представлению таб-бара.
        self.tabBarController?.view.addSubview(reusableView)
        
        // Задает начальные параметры для анимации.
        let height = 335
        reusableView.frame = CGRect(x: 0, y: self.tabBarController!.view.frame.height, width: self.tabBarController!.view.frame.width, height: CGFloat(height))
        self.tabBarController?.view.layoutIfNeeded()
        
        // Используется анимация для плавного появления представления с использованием пружинного эффекта.
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            // Уменьшает координату y представления, чтобы оно переместилось вверх (появилось).
            self.reusableView.frame.origin.y -= CGFloat(height)
        })
        
        // Задает ограничения для представления.
        NSLayoutConstraint.activate([
            reusableView.bottomAnchor.constraint(equalTo: self.tabBarController!.view.bottomAnchor),
            reusableView.leadingAnchor.constraint(equalTo: self.tabBarController!.view.leadingAnchor),
            reusableView.trailingAnchor.constraint(equalTo: self.tabBarController!.view.trailingAnchor),
            reusableView.heightAnchor.constraint(equalToConstant: 335),
        ])
    }

    
    // Показывает представление запроса доступа к камере.
    func showCameraAccessView() {
        // Настройка затемненного фона.
        setupDarkView()
        
        // Создание и настройка ReusableAlertView с типом .camera.
        reusableView = ReusableAlertView(type: .camera)
        reusableView.delegate = self
        reusableView.darkView = self.darkView
        reusableView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавление reusableView на иерархию представлений.
        self.tabBarController?.view.addSubview(reusableView)
        
        // Задание начальных размеров и положения reusableView для анимации.
        let height = 335
        reusableView.frame = CGRect(x: 0, y: self.tabBarController!.view.frame.height, width: self.tabBarController!.view.frame.width, height: CGFloat(height))
        self.tabBarController?.view.layoutIfNeeded()
        
        // Анимация появления reusableView с использованием пружинного эффекта.
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.reusableView.frame.origin.y -= CGFloat(height)
        })
        
        // Активация NSLayoutConstraint для правильного размещения reusableView.
        NSLayoutConstraint.activate([
            reusableView.bottomAnchor.constraint(equalTo: self.tabBarController!.view.bottomAnchor),
            reusableView.leadingAnchor.constraint(equalTo: self.tabBarController!.view.leadingAnchor),
            reusableView.trailingAnchor.constraint(equalTo: self.tabBarController!.view.trailingAnchor),
            reusableView.heightAnchor.constraint(equalToConstant: 335),
        ])
    }

    
    // Скрывает представление с анимацией.
    func hideAlertViewWithAnimation() {
        // Высота представления.
        let height = 335
        
        // Используется анимация для плавного скрытия представления с использованием пружинного эффекта.
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            // Увеличивает координату y представления, чтобы оно переместилось вниз (скрылось).
            self.reusableView.frame.origin.y += CGFloat(height)
        }) { _ in
            // Удаляет представление из иерархии представлений после завершения анимации.
            self.reusableView.removeFromSuperview()
        }
    }

    
    // Настройка затемненного фона.
    private func setupDarkView() {
        // Создание эффекта размытия.
        let blurEffect = UIBlurEffect(style: .regular)
        
        // Создание и настройка UIVisualEffectView с использованием эффекта размытия.
        darkView = UIVisualEffectView(effect: blurEffect)
        
        // Установка размеров затемненного фона такими же, как и у view контроллера.
        darkView?.frame = view.bounds
        
        // Установка автоматического изменения размеров для адаптации к изменениям размеров view контроллера.
        darkView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Добавление затемненного фона на иерархию представлений.
        if let darkView = darkView {
            view.addSubview(darkView)
        }
    }

}
