//
//  SettingView.swift
//  DevCommunity
//
//  Created by A_Mcflurry on 4/17/24.
//

import SwiftUI

struct SettingView: View {
	var body: some View {
		List {
			Section {
				NavigationLink {

				} label: {
					Label(
						title: { Text("프로필 관리") },
						icon: { Image(systemName: "person.fill").foregroundStyle(.green) }
					)
				}

				NavigationLink {

				} label: {
					Label(
						title: { Text("계정 관리") },
						icon: { Image(systemName: "key.fill").foregroundStyle(.yellow) }
					)
				}

			} header: {
				Text("계정")
			}

			Section {
				NavigationLink {

				} label: {
					Label(
						title: { Text("문의하기") },
						icon: { Image(systemName: "headphones").foregroundStyle(.indigo) }
					)
				}

				NavigationLink {

				} label: {
					Label(
						title: { Text("이용 약관") },
						icon: { Image(systemName: "pencil").foregroundStyle(.red) }
					)
				}

				NavigationLink {

				} label: {
					Label(
						title: { Text("개인정보 처리방침") },
						icon: { Image(systemName: "hand.raised.fill").foregroundStyle(.orange) }
					)
				}

			} header: {
				Text("서비스 이용")
			}
		}
		.navigationTitle("설정")
		.navigationBarTitleDisplayMode(.inline)
		.listStyle(.plain)
		.background(.white)
		.headerProminence(.increased)

	}
}

#Preview {
	NavigationStack {
		SettingView()
	}
}
