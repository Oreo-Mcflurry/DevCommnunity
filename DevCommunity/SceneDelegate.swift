//
//  SceneDelegate.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = UINavigationController(rootViewController: InitialViewController())
		window?.makeKeyAndVisible()
	}

	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}

	func sceneDidBecomeActive(_ scene: UIScene) {

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


//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//	 var window: UIWindow?
//
//	 var errorWindow: UIWindow?
//
//	 func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//
//		  guard let scene = (scene as? UIWindowScene) else { return }
//
//		  window = UIWindow(windowScene: scene)
//
//		  let vc = InitailViewController()
//
//		  window?.rootViewController = vc
//		  window?.makeKeyAndVisible()
//
//		  NetworkMonitorManager.shared.startMonitoring() { [weak self] connectionStatus in
//				switch connectionStatus {
//				case .satisfied:
//					 self?.removeNetworkErrorWindow()
//				case .unsatisfied:
//					 self?.loadNetworkErrorWindow(on: scene)
//				default:
//					 break
//				}
//		  }
//	 }
//
//	 private func loadNetworkErrorWindow(on scene: UIScene) {
//		  if let windowScene = scene as? UIWindowScene {
//				let window = UIWindow(windowScene: windowScene)
//				window.windowLevel = .statusBar
//				window.makeKeyAndVisible()
//
//				let noNetworkView = NoNetworkView(frame: window.frame)
//				window.addSubview(noNetworkView)
//				self.errorWindow = window
//		  }
//	 }
//
//	 private func removeNetworkErrorWindow() {
//		  errorWindow?.resignKey()
//		  errorWindow?.isHidden = true
//		  errorWindow = nil
//	 }
//
//	 func sceneDidDisconnect(_ scene: UIScene) {
//		  // Called as the scene is being released by the system.
//		  // This occurs shortly after the scene enters the background, or when its session is discarded.
//		  // Release any resources associated with this scene that can be re-created the next time the scene connects.
//		  // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
//		  NetworkMonitorManager.shared.stopMonitoring()
//	 }
