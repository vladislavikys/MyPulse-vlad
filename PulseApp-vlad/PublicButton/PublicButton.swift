//
//  PublicButton.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit

class PublicButton: UIButton{
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton(){
        configuration = .plain() //  создаем новую кнопку с простым стилем (без изображений или дополнительных эффектов)
        translatesAutoresizingMaskIntoConstraints = false
        layer.backgroundColor = UIColor(red: 0.443, green: 0.4, blue: 0.976, alpha: 1).cgColor
        layer.cornerRadius = 30
        configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ input in
            var output = input
            output.font = .mediumFont(size: 19)
            output.foregroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            return output
        })
    }
}
