//
//  Job.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/4/24.
//

import Foundation
import UIKit

enum Job: String, CaseIterable {
	case ios = "iOS"
	case back = "백엔드"
	case pm = "PM"
	case uiux = "UI/UX"
	case none
}

extension Job {
	static func getCase(_ data: String) -> Job {
		for item in Job.allCases {
			if item.rawValue == data {
				return item
			}
		}

		return .none
	}

	var image: UIImage {
		switch self {
		case .ios:
			return .apple
		case .back:
			return .back
		case .pm:
			return .pm
		case .uiux:
			return .UIUX
		case .none:
			return UIImage(systemName: "star")!
		}
	}
}
