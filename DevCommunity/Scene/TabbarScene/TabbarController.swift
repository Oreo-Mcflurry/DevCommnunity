//
//  TabbarController.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/16/24.
//

import UIKit

final class TabbarViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setTabbarViewControllers()
		configureTabbarDesign()
	}

	private func setTabbarViewControllers() {
		let homeVC = UINavigationController(rootViewController: EventsViewController())
		homeVC.tabBarItem = UITabBarItem(title: "Events", image: UIImage(systemName: "calendar"), tag: 0)


		self.viewControllers = [homeVC]
	}

	private func configureTabbarDesign() {
		tabBar.layer.cornerRadius = tabBar.frame.height * 0.41
		tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		tabBar.backgroundColor = .white
		tabBar.layer.borderColor = UIColor.systemGray5.cgColor
		tabBar.layer.borderWidth = 1
		tabBar.layer.shadowColor = UIColor.black.cgColor
		tabBar.layer.shadowOpacity = 0.2
		tabBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
	}


}
