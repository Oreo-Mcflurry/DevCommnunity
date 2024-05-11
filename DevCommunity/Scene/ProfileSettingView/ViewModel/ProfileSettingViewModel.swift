//
//  ProfileSettingViewModel.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/10/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileSettingViewModel: InputOutputViewModelProtocol {
	private let requestManager = ProfileRequestManager()
	
	struct Input {
		let inputViewDidAppear: Observable<Void>
		let inputSaveButtonClicked: Observable<(String?, String?)>
		let inputNickNameTextField: ControlProperty<String?>
		let inputPhoneNumTextField: ControlProperty<String?>
	}

	struct Output {
		let outputViewDidAppear: Driver<ProfileResultModel>
		let outputSaveButtonClicked: Driver<Void>
		let outputSaveButtonEnabled: Driver<Bool>
	}

	private(set) var disposeBag = DisposeBag()

	func transform(input: Input) -> Output {
		let outputViewDidAppear = BehaviorRelay(value: ProfileResultModel(nick: "", phoneNum: ""))
		let outputSaveButtonClicked = PublishRelay<Void>()
		let outputSaveButtonEnabled = BehaviorRelay(value: false)

		input.inputViewDidAppear
			.flatMap { self.requestManager.getMyProfile() }
			.subscribe(with: self) { owner, value in
				switch value {
				case .success(let result):
					UserDefaults.standard.saveProfileResult(result)
					outputViewDidAppear.accept(result)
				case .failure(_):
					break;
				}
			}.disposed(by: disposeBag)

		Observable.combineLatest(input.inputNickNameTextField.orEmpty, input.inputPhoneNumTextField.orEmpty)
			.map { $0.0.count >= 2 && (Int($0.1) != nil && $0.1.count == 11) }
			.bind(to: outputSaveButtonEnabled)
			.disposed(by: disposeBag)

		input.inputSaveButtonClicked
			.map { ($0.0 ?? "", $0.1 ?? "") }
			.map { ProfileEditModel(nickname: $0.0, phoneNum: $0.1) }
			.flatMap { value in
				self.requestManager.putProfileEdit(query: value)
			}
			.subscribe(with: self) { owner, value in
				switch value {
				case .success(let result):
					UserDefaults.standard.saveProfileSettingRequest(result)
					outputSaveButtonClicked.accept(Void())
				case .failure(_):
					break
				}
			}.disposed(by: disposeBag)


		return Output(outputViewDidAppear: outputViewDidAppear.asDriver(),
						  outputSaveButtonClicked: outputSaveButtonClicked.asDriver(onErrorJustReturn: ()),
						  outputSaveButtonEnabled: outputSaveButtonEnabled.asDriver())
	}
}
