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
        
    }
    
    // MARK: - Capture Session
    
    // Инициализирует и запускает захват видео.
    func initCaptureSession() {
        
    }
    
    // Деинициализирует захват видео, останавливает видео и выключает вспышку.
    func deinitCaptureSession() {
        
    }
    
    // MARK: - Torch Control
    
    // Включает или выключает вспышку на устройстве для освещения съемки видео.
    func toggleTorch(status: Bool) {
        
    }
    
    // MARK: - Measurement
    
    // Запускает измерение пульса.
    func startMeasurement() {
    }

    
    func defaultState() {
        
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
            let blurEffect = UIBlurEffect(style: .dark) // Или .light, в зависимости от вашего предпочтения

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
