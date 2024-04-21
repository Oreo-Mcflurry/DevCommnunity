//
//  PostsSectionModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/19/24.
//

import Foundation
import RxDataSources

struct PostsSectionModel {
	var header: String
	var items: [EventPost]
}

extension PostsSectionModel: AnimatableSectionModelType {
	typealias Identity = String

	var identity: String {
		return header
	}

	init(original: PostsSectionModel, items: [EventPost]) {
		self = original
		self.items = items
	}
}
