//
//  SceneDelegate.swift
//  PulseApp-vlad
//
//  Created by Влад on 21.12.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
    }

    func createHeartNC() -> UINavigationController {
        let heart = HeartRateController()
        heart.tabBarItem = UITabBarItem(title: "Heart", image: UIImage(named: "heart"), tag: 0)
        
        return UINavigationController(rootViewController: heart)
    }

    func createHistoryNC() -> UINavigationController{
        let history = HistoryViewController()
        history.tabBarItem = UITabBarItem(title: "History", image: UIImage(named: "history"), tag: 1)
        
        return UINavigationController(rootViewController: history)
    }
    
    func createDietNC() -> UINavigationController{
        let diet = DietViewController()
        diet.tabBarItem = UITabBarItem(title: "Diet", image: UIImage(named: "diet"), tag: 2)
        
        return UINavigationController(rootViewController: diet)
    }
    
    func createTestNC() -> UINavigationController{
        let test = TestViewController()
        test.tabBarItem = UITabBarItem(title: "Test", image: UIImage(named: "test"), tag: 3)
        
        return UINavigationController(rootViewController: test)
    }
    
    func createProfileNC() -> UINavigationController{
        let profile = ProfileViewController()
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 4)
        
        return UINavigationController(rootViewController: profile)
    }
    
    func createTabbar() -> UITabBarController{
       
        let tabbar = TabController()
        tabbar.viewControllers = [createHeartNC(), createHistoryNC(), createDietNC(), createTestNC(), createProfileNC()]
        
        return tabbar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

