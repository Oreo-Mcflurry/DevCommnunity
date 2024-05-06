//
//  UIViewController+Preview+Extension.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/3/24.
//

import UIKit
import SwiftUI

extension UIViewController {
	 private struct SwiftUIView: UIViewControllerRepresentable {
				let viewController: UIViewController

				func makeUIViewController(context: Context) -> UIViewController {
					 return viewController
				}

				func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
				}
		  }

		  func toSwiftUIView() -> some View {
				SwiftUIView(viewController: self)
		  }
}
