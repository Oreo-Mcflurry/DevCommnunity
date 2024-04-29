//
//  PostsSectionModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/19/24.
//

import Foundation
import RxDataSources

struct EventsPostsSectionModel: SectionModelProtocol {	
	var header: String
	var items: [EventPost]
	var row: Row
}

extension EventsPostsSectionModel: AnimatableSectionModelType {
	typealias Identity = String

	var identity: String {
		return header
	}

	init(original: EventsPostsSectionModel, items: [EventPost]) {
		self = original
		self.items = items
	}
}
