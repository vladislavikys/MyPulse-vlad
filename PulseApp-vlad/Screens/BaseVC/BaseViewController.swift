//
//  BaseViewController.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import UIKit

class BaseViewController: UIViewController {
    
    public var backgoundImageView = UIImageView()
    public var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        view.backgroundColor = UIColor.white
    }

    func setBackground(){
        view.addSubview(backgoundImageView)
        view.addSubview(titleLabel)
        backgoundImageView.image = UIImage(named: "backgroundColor")
        backgoundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .systemFont(ofSize: 28)
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(red: 0.114, green: 0.114, blue: 0.145, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            backgoundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgoundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgoundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgoundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //titleLabel.heightAnchor.constraint(equalToConstant: 33),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        ])
    }
}

extension UIFont {
    static func regularFont(size: CGFloat) -> UIFont?{
        return UIFont(name: "SFProDisplay-Regular", size: size)
    }
    
    static func boldFont(size: CGFloat) -> UIFont?{
        return UIFont(name: "SFProDisplay-Bold", size: size)
    }
    
    static func mediumFont(size: CGFloat) -> UIFont?{
        return UIFont(name: "SFProDisplay-Medium", size: size)
    }
}

