import UIKit

class TabController: UITabBarController {

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        setupTabs()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customizeTabBarAppearance()
        adjustTabBarHeight()
    }

    // MARK: - Configuration Methods

    private func configureTabBar() {
        tabBar.tintColor = #colorLiteral(red: 0.9992823005, green: 0.5240220428, blue: 0.2201012969, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        tabBar.layer.cornerRadius = 20
    }

    private func customizeTabBarAppearance() {
        let tabBarHeight: CGFloat = 100
        tabBar.frame.size.height = tabBarHeight
        tabBar.frame.origin.y = view.frame.size.height - tabBarHeight

        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -10)
        tabBar.standardAppearance = appearance
    }

    // MARK: - Tab Setup

    private func setupTabs() {
        viewControllers = [
            createTab(with: "Heart", image: UIImage(named: "heart"), viewController: HeartRateController()),
            createTab(with: "History", image: UIImage(named: "history"), viewController: HistoryViewController()),
            createTab(with: "Diet", image: UIImage(named: "apple"), viewController: DietViewController()),
            createTab(with: "Test", image: UIImage(named: "test"), viewController: TestViewController()),
            createTab(with: "Profile", image: UIImage(named: "profile"), viewController: ProfileViewController())
        ]
    }

    private func createTab(with title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }

    // MARK: - Utility Methods

    private func adjustTabBarHeight() {
        tabBar.standardAppearance.shadowColor = UIColor.clear
    }
}
