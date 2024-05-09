//
//  SignUpViewModel.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel: InputOutputViewModelProtocol {
	private let mainText = [
		"전화번호를\n입력해주세요",
		"닉네임을\n입력해주세요",
		"비밀번호를\n입력해주세요",
		"이메일을\n입력해주세요",
	]

	private let subTrueText = [
		"가입하시는 분의 정보로 입력해주세요",
		"닉네임은 2자 이상 입력해주세요",
		"비밀번호는 8자 이상 입력해주세요.",
		"입력하신 이메일은 로그인할 때 사용됩니다.",
	]

	struct Input {
		let inputDidBegin: PublishRelay<Int>
		let inputDidEnd: PublishRelay<Int>
		let inputDidEndOnExit: PublishRelay<(String?, Int)>
		let inputNextButton: PublishRelay<Void>
		let inputPhoneText: ControlProperty<String?>
	}

	struct Output {
		let outputDidBegin: Driver<Int>
		let outputDidEnd: Driver<Int>
		let outputDidEndOnExit: Driver<(Bool, Int)>
		let outputMainLabelText: Driver<String>
		let outputSubLabelText: Driver<String>
		let outputNextButton: Driver<Void>
	}

	private(set) var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputMainLabelText = BehaviorRelay(value: "")
		let outputSubLabelText = BehaviorRelay(value: "")
		let outputDidEndOnExit = BehaviorRelay(value: (false, 0))

		let inputDidBegin = input.inputDidBegin.share()

		inputDidBegin
			.map { self.mainText[$0] }
			.bind(to: outputMainLabelText)
			.disposed(by: disposeBag)

		inputDidBegin
			.map { self.subTrueText[$0] }
			.bind(to: outputSubLabelText)
			.disposed(by: disposeBag)

		input.inputDidEndOnExit
			.map { (self.isValid($0), $0.1-1) }
			.bind(to: outputDidEndOnExit)
			.disposed(by: disposeBag)

		input.inputPhoneText
			.map { self.isValid(($0, 0)) }
			.map { ($0, -1) }
			.bind(to: outputDidEndOnExit)
			.disposed(by: disposeBag)

		return Output(outputDidBegin: input.inputDidBegin.asDriver(onErrorJustReturn: 0),
						  outputDidEnd: input.inputDidEnd.asDriver(onErrorJustReturn: 0),
						  outputDidEndOnExit: outputDidEndOnExit.asDriver(),
						  outputMainLabelText: outputMainLabelText.asDriver(),
						  outputSubLabelText: outputSubLabelText.asDriver(), 
						  outputNextButton: input.inputNextButton.asDriver(onErrorJustReturn: Void()))
	}

	private func isValid(_ data: (String?, Int)) -> Bool {
		guard let text = data.0 else { return false }
		let index = data.1

		if index == 3 {
			return text.contains("@")
		} else if index == 2 {
			return text.count >= 8
		} else if index == 1 {
			return text.count >= 2
		} else {
			return Int(text) != nil && text.count == 11
		}
	}
}
