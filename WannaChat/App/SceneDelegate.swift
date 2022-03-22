//
//  SceneDelegate.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import FirebaseAuth
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var authListener: AuthStateDidChangeListenerHandle?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        autoLogin()
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

private extension SceneDelegate {
    
    // MARK: - AutoLogin
    
    func autoLogin() {
        authListener = Auth.auth().addStateDidChangeListener({ auth, user in
            
            if let authListener = self.authListener {
                Auth.auth().removeStateDidChangeListener(authListener)
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let rootView = self.isLoggedIn(with: user) ? MainRouter.getViewController() : AuthRouter.getViewController()
                self.window?.rootViewController = rootView
            }
        })
    }
    
    func isLoggedIn(with user: FirebaseAuth.User?) -> Bool{
        user != nil && UserDefaults.standard.object(forKey: kCURRENTUSER) != nil
    }

}

