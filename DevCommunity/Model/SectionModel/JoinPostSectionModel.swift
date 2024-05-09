//
//  JoinPostSectionModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/9/24.
//

import Foundation
import RxDataSources

struct JoinPostSectionModel: SectionModelProtocol {
	var header: String
	var items: [AppliedInfo]
	var row: Row
}

extension JoinPostSectionModel: AnimatableSectionModelType {
	typealias Identity = String

	var identity: String {
		return header
	}

	init(original: JoinPostSectionModel, items: [AppliedInfo]) {
		self = original
		self.items = items
	}
}
