//
//  SceneDelegate.swift
//  GistsTests
//
//  Created by Chrystian Salgado on 10/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = getWindow(windowScene)
        ApplicationCoordinator(window: window).start()
    }

    private func getWindow(_ windowScene: UIWindowScene) -> UIWindow {
        let _window = UIWindow(windowScene: windowScene)
        
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .phone {
            let _window = UIWindow(frame: UIScreen.main.bounds)
            _window.frame = UIScreen.main.bounds
        }
        
        return _window
    }
}
