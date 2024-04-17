//
//  DeleteBackButton+Extension.swift
//  BuyingMyHome
//
//  Created by A_Mcflurry on 3/15/24.
//

import UIKit

extension UINavigationController {
	open override func viewWillLayoutSubviews() {
		navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}
}
