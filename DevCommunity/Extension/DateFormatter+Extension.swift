//
//  DateFormatter+Extension.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/5/24.
//

import Foundation

extension DateFormatter {
	 static let formatter: DateFormatter = {
		  let formatter = DateFormatter()
		  formatter.dateFormat = "yyyy-MM-dd"
		  return formatter
	 }()
}
