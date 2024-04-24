//
//  DetailViewModek.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/22/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: InputOutputViewModelProtocol {
	struct Input {
	}

	struct Output {
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		return Output()
	}
}
