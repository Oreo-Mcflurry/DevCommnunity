//
//  HomeViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/15/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class EventsViewModel: InputOutputViewModelProtocol {

	struct Input {

	}

	struct Output {

	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		return Output()
	}
}
