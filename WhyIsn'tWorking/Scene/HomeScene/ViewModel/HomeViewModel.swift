//
//  HomeViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel: InputOutputViewModelProtocol {
	struct Input {

	}

	struct Output {

	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		return Output()
	}
}
