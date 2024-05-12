//
//  SettingView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/17/24.
//

import SwiftUI
import iamport_ios
import WebKit

struct SettingView: View {
	var body: some View {
		List {
			accountSection
			serviceSection
		}
		.navigationTitle("설정")
		.navigationBarTitleDisplayMode(.inline)
		.listStyle(.plain)
		.background(.white)
		.headerProminence(.increased)
	}

	private var serviceSection: some View {
		Section {
			qnaView
			termsView
			privacyView
			iamportPayView
		} header: {
			Text("서비스 이용")
		}
	}

	private var iamportPayView: some View {
		NavigationLink {
			NavigationLazyView(IamportPaymentViewController().toSwiftUIView())
		} label: {
			Label(
				title: { Text("광고 제거 구매 (100원)") },
				icon: { Image(systemName: "person.fill").foregroundStyle(.cyan) }
			)
		}
	}

	private var privacyView: some View {
		Link(destination: URL(string: "https://inhoyoo-ios.notion.site/DevCommunity-2b299eb278ab46978f6d48f149cf3fe5?pvs=4")!, label: {
			Label(
				title: { Text("개인정보 처리방침") },
				icon: { Image(systemName: "hand.raised.fill").foregroundStyle(.orange) }
			)
		})
	}

	private var termsView: some View {
		Link(destination: URL(string: "https://inhoyoo-ios.notion.site/DevCommunity-a8cfe60799e6437a82c34246b8bb3819?pvs=4")!, label: {
			Label(
				title: { Text("이용 약관") },
				icon: { Image(systemName: "pencil").foregroundStyle(.red) }
			)
		})
	}

	private var qnaView: some View {
		Link(destination: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdwZLnGi8e1rXIKHodpHZ1jc_J9jAIC4lFS2JPF9TDMXHHGyQ/viewform")!, label: {
			Label(
				title: { Text("문의하기") },
				icon: { Image(systemName: "headphones").foregroundStyle(.indigo) }
			)
		})
	}

	private var accountSection: some View {
		Section {
			managingProfileView
			managingAccountView
		} header: {
			Text("계정")
		}
	}

	private var managingProfileView: some View {
		NavigationLink {
			NavigationLazyView(ProfileSettingViewController().toSwiftUIView())
		} label: {
			Label(
				title: { Text("프로필 관리") },
				icon: { Image(systemName: "person.fill").foregroundStyle(.green) }
			)
		}
	}

	private var managingAccountView: some View {
		NavigationLink {
			NavigationLazyView(AccountSettingView())
		} label: {
			Label(
				title: { Text("계정 관리") },
				icon: { Image(systemName: "key.fill").foregroundStyle(.yellow) }
			)
		}
	}
}
