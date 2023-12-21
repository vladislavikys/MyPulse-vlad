//
//  TabController.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import Foundation
import UIKit

class TabController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = #colorLiteral(red: 0.9992823005, green: 0.5240220428, blue: 0.2201012969, alpha: 1)
        self.tabBar.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        self.tabBar.layer.cornerRadius = 20
        
        self.setupTabs()
    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        tabBarController?.tabBar.isUserInteractionEnabled = false
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tabBarHeight:CGFloat = 100
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        tabBar.standardAppearance = appearance
    }
    
    private func setupTabs(){
        
        let heart = self.createNav(with: "Heart", and: UIImage(named: "heart"), vc: HeartRateController())
        let history = self.createNav(with: "History", and: UIImage(named: "history"), vc: HistoryViewController())
        let diet = self.createNav(with: "Diet", and: UIImage(named: "apple"), vc: DietViewController())
        let test = self.createNav(with: "Test", and: UIImage(named: "test"), vc: TestViewController())
        let profile = self.createNav(with: "Profile", and: UIImage(named: "profile"), vc: ProfileViewController())
        
        self.setViewControllers([heart, history, diet, test, profile], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}
