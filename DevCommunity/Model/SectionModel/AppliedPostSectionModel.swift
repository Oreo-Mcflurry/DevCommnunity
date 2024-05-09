//
//  JoinPostSectionModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/9/24.
//

import Foundation
import RxDataSources

struct AppliedPostSectionModel: SectionModelProtocol {
	var header: String
	var items: [AppliedInfo]
	var row: Row
}

extension AppliedPostSectionModel: AnimatableSectionModelType {
	typealias Identity = String

	var identity: String {
		return header
	}

	init(original: AppliedPostSectionModel, items: [AppliedInfo]) {
		self = original
		self.items = items
	}
}
