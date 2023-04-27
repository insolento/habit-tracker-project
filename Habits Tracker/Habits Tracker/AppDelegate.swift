import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.backgroundColor = .systemBackground
        
        let tabbar = UITabBarController()
        tabbar.tabBar.backgroundColor = .systemGray6
        tabbar.tabBar.tintColor = UIColor(named: "PurpleColor")
        tabbar.tabBar.backgroundColor = .systemGray6
        
        let info = InfoViewController()
        let infoNC = UINavigationController(rootViewController: info)
        let infoTBI = UITabBarItem()
        infoTBI.image = UIImage(systemName: "info.circle.fill")
        infoNC.tabBarItem = infoTBI
        infoNC.title = "Info"

        let habits = HabitsViewController()
        let habitsNC = UINavigationController(rootViewController: habits)
        let habitsTBI = UITabBarItem()
        habitsTBI.image = UIImage(named: "HabitsLogo")
        habitsNC.tabBarItem = habitsTBI
        habitsNC.title = "Habits"

        tabbar.viewControllers = [habitsNC, infoNC]
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()

        return true
    }
}
