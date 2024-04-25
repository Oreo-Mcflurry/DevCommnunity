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
		let inputOffset: ControlProperty<CGPoint>
		let inputDismissButton: ControlEvent<Void>
		let inputHeartButton: ControlEvent<Void>
		let inputViewDidAppear: Observable<Void>
	}

	struct Output {
		let outputHeroImageOpacity: Driver<Float>
		let outputHeroImageTransform: Driver<CGAffineTransform>
		let outputTitleViewIsHidden: Driver<Bool>
		let outputTitleViewOpacity: Driver<Float>
		let outputDismissButton: Driver<Void>
		let outputHeartButton: Driver<Void>
	}

	var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputHeroImageOpacity: BehaviorRelay<Float> = BehaviorRelay(value: 0.0)
		let outputHeroImageTransform: BehaviorRelay<CGAffineTransform> = BehaviorRelay(value: CGAffineTransform(scaleX: 0, y: 0))
		let outputTitleViewIsHidden = BehaviorRelay(value: false)
		let outputTitleViewOpacity: BehaviorRelay<Float> = BehaviorRelay(value: 0.0)

		input.inputOffset
			.bind(with: self) { owner, value in
				let scaleFactor = 1 + (max(0, -value.y) / 120)
				outputHeroImageTransform.accept(CGAffineTransform(scaleX: scaleFactor, y: scaleFactor))

				let opacityFactor = Float(max(0, 1-value.y/100))
				outputHeroImageOpacity.accept(opacityFactor)

				if 1-opacityFactor < 0.1 {
					outputTitleViewIsHidden.accept(true)
				} else {
					outputTitleViewIsHidden.accept(false)
					outputTitleViewOpacity.accept(1-opacityFactor)
				}
			}.disposed(by: disposeBag)

		return Output(outputHeroImageOpacity: outputHeroImageOpacity.asDriver(),
						  outputHeroImageTransform: outputHeroImageTransform.asDriver(),
						  outputTitleViewIsHidden: outputTitleViewIsHidden.asDriver(),
						  outputTitleViewOpacity: outputTitleViewOpacity.asDriver(),
						  outputDismissButton: input.inputDismissButton.asDriver(),
						  outputHeartButton: input.inputHeartButton.asDriver())
	}
}
