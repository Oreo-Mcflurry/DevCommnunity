//
//  InputOutputViewModelProtocol.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/10/24.
//

import Foundation
import RxSwift

protocol InputOutputViewModelProtocol {
	associatedtype Input
	associatedtype Output

	var disposeBag: DisposeBag { get }

	func transform(input: Input) -> Output
}
