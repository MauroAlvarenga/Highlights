//
//  AppDelegate.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 29/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setNavBarStyle()
        checkForToken()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Save favorites to UserDefaults when app has terminated.
        let favoritesList = Array(FavoritesList.shared.getFavorites())
        let defaults = UserDefaults.standard
        defaults.set(favoritesList, forKey: "favoritesList")
    }
    
    // Set Global navigation bar styles.
    private func setNavBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .yellowML
        appearance.titleTextAttributes = [.foregroundColor: UIColor.textPrimary, .font: UIFont(name: "Proxima Nova", size: 24)!]
        appearance.setBackIndicatorImage(UIImage(named: "ArrowLeft24"), transitionMaskImage: UIImage(named: "ArrowLeft24"))
        UINavigationBar.appearance().tintColor = .textPrimary
        
        // NavBar Shadow
        UINavigationBar.appearance().layer.shadowColor = UIColor.lightGray.cgColor
        UINavigationBar.appearance().layer.shadowOpacity = 0.7
        UINavigationBar.appearance().layer.shadowOffset = CGSize(width: 0, height: 2)
        UINavigationBar.appearance().layer.shadowRadius = 2
        
        // Unify styles
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

    }
    
    // Check for a saved token or ask for a new one if it doesn´t work anymore.
    private func checkForToken() {
        let defaults = UserDefaults.standard
        if let token = defaults.object(forKey: "accessToken") as? String {
            print("Habemus Token! \(token)")
            // If there's a token, test it's working (not expired)
            let tokenService = TokenService()
            tokenService.testToken(token) { isWorking in
                if !isWorking {
                    print("TOKEN NOT WORKING ALERT")
                    self.getToken()
                }
            }
        } else {
            self.getToken()
        }
    }
    
    // Used to generate a new token in case the actual one is expired
    private func getToken() {
        let usedTokenError = "Error validating grant. Your authorization code or refresh token may be expired or it was already used"
        let apiToken = TokenService()
        apiToken.getToken { token in
            print("Got a first time token: \(token)")
            if token == usedTokenError {
                apiToken.getRefreshToken { refreshedToken in
                    print("Had to get a refresh token: \(refreshedToken)")
                }
            }
        }
    }
    
    
    //...
}

