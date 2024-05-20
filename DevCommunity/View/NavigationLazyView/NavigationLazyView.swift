//
//  NavigationLazyView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/12/24.
//

import SwiftUI

struct NavigationLazyView<T: View>: View {
	let build: () -> T

	init(_ build: @autoclosure @escaping () -> T) {
		self.build = build
	}

	var body: some View {
		build()
	}
}



