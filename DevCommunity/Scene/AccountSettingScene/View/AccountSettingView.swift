//
//  AccountSettingView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 5/9/24.
//

import SwiftUI
import UIKit
import RxSwift

struct AccountSettingView: View {
	private let requestManger = AuthRequestManager()
	private let disposeBag = DisposeBag()
	@State private var logoutButtonClicked = false
	@State private var withdrawButtonClicked = false

	var body: some View {
		List {
			section
		}
		.listStyle(.inset)
		.headerProminence(.increased)
	}

	private var section: some View {
		Section {
			logoutButton
			withdrawButton
		} header: {
			Text("계정 관련")
		}
	}

	private var withdrawButton: some View {
		Button {
			self.withdrawButtonClicked.toggle()
		} label: {
			Label(
				title: { Text("회원탈퇴") },
				icon: { Image(systemName: "trash.fill").foregroundStyle(.purple) }
			)
		}
		.alert(isPresented: $withdrawButtonClicked) {
			Alert(title: Text("탈퇴 하시겠습니까?"), message: Text("확인을 누르면 탈퇴 합니다"), primaryButton: .destructive(Text("취소")), secondaryButton: .default(Text("확인"), action: {
				requestManger.withDrawRequst()
					.subscribe { result in
						switch result {
						case .success(_):
							goToSignInViewController()
						case .failure(_):
							withdrawButtonClicked.toggle()
						}
					} onFailure: { _ in
						withdrawButtonClicked.toggle()
					}.disposed(by: disposeBag)
			}))
		}
	}

	private var logoutButton: some View {
		Button {
			self.logoutButtonClicked.toggle()
		} label: {
			Label(
				title: { Text("로그아웃") },
				icon: { Image(systemName: "arrow.right").foregroundStyle(.indigo) }
			)
		}
		.alert(isPresented: $logoutButtonClicked) {
			Alert(title: Text("로그아웃 하시겠습니까?"), message: Text("확인을 누르면 로그아웃 합니다"), primaryButton: .destructive(Text("취소")), secondaryButton: .default(Text("확인"), action: {
				goToSignInViewController()
			}))
		}
	}

	private func goToSignInViewController() {
		let signIn = UINavigationController(rootViewController: SignInViewController())
		let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
		sceneDelegate.window?.rootViewController = signIn
		UserDefaults.standard.deleteAll()
	}
}
