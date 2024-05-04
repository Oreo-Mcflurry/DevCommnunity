//
//  UIViewController+Preview+Extension.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import UIKit
import SwiftUI

#if DEBUG
extension UIViewController {
	 private struct Preview: UIViewControllerRepresentable {
				let viewController: UIViewController

				func makeUIViewController(context: Context) -> UIViewController {
					 return viewController
				}

				func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
				}
		  }

		  func toPreview() -> some View {
				Preview(viewController: self)
		  }
}
#endif
