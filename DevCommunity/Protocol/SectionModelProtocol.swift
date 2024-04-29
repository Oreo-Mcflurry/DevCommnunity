//
//  SectionModelProtocol.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/30/24.
//

import Foundation
import Differentiator

protocol SectionModelProtocol {
	associatedtype Item: IdentifiableType

	var header: String { get }
	var items: [Item] { get }
	var row: Row { get }
}
