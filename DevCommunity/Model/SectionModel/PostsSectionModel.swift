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
	var items: [Item]
}

extension PostsSectionModel: AnimatableSectionModelType {
	typealias Item = EventPost
	typealias Identity = String

	var identity: String {
		return header
	}

	init(original: PostsSectionModel, items: [Item]) {
		self = original
		self.items = items
	}
}
