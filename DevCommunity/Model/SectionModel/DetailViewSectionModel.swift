//
//  DetailViewSectionModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/29/24.
//

import Foundation
import RxDataSources

struct DetailViewSectionModel: SectionModelProtocol {
	var header: String
	var items: [PartyPost]
	var row: Row
}

extension DetailViewSectionModel: AnimatableSectionModelType {
	typealias Identity = String

	var identity: String {
		return header
	}

	init(original: DetailViewSectionModel, items: [PartyPost]) {
		self = original
		self.items = items
	}
}
