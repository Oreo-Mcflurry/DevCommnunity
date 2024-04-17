//
//  ReusableID.swift
//  LSLPBasic
//
//  Created by jack on 2024/04/09.
//

import UIKit

protocol ReusableID { }

extension UIView: ReusableID { }

extension ReusableID {
    static var identifier: String {
        return String(describing: self)
    }
}
