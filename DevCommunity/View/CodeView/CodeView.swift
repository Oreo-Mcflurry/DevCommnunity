//
//  CodeView.swift
//  WhyIsn'tWorking
//
//  Created by A_Mcflurry on 4/11/24.
//

import SwiftUI
import MarkdownUI
import Splash

struct CodeView: View {
	@Environment(\.colorScheme) private var colorScheme
	let languageType: String
	let inputText: String
	var body: some View {
		VStack {
			Markdown {
		#"""
 ```\#(languageType)
 \#(inputText)
 ```
 """#
			}
			.markdownCodeSyntaxHighlighter(.splash(theme: self.theme))
		 }
	 }

	private var theme: Splash.Theme {
	  switch self.colorScheme {
	  case .dark:
		 return .wwdc17(withFont: .init(size: 16))
	  default:
		 return .sunset(withFont: .init(size: 16))
	  }
	}
}

struct SplashCodeSyntaxHighlighter: CodeSyntaxHighlighter {
  private let syntaxHighlighter: SyntaxHighlighter<TextOutputFormat>

  init(theme: Splash.Theme) {
	 self.syntaxHighlighter = SyntaxHighlighter(format: TextOutputFormat(theme: theme))
  }

  func highlightCode(_ content: String, language: String?) -> Text {
	 guard language?.lowercased() == "swift" else {
		return Text(content)
	 }

	 return self.syntaxHighlighter.highlight(content)
  }
}

extension CodeSyntaxHighlighter where Self == SplashCodeSyntaxHighlighter {
  static func splash(theme: Splash.Theme) -> Self {
	 SplashCodeSyntaxHighlighter(theme: theme)
  }
}


struct TextOutputFormat: OutputFormat {
	private let theme: Splash.Theme

  init(theme: Splash.Theme) {
	 self.theme = theme
  }

  func makeBuilder() -> Builder {
	 Builder(theme: self.theme)
  }
}

extension TextOutputFormat {
  struct Builder: OutputBuilder {
	 private let theme: Splash.Theme
	 private var accumulatedText: [Text]

	 fileprivate init(theme: Splash.Theme) {
		self.theme = theme
		self.accumulatedText = []
	 }

	 mutating func addToken(_ token: String, ofType type: TokenType) {
		let color = self.theme.tokenColors[type] ?? self.theme.plainTextColor
		self.accumulatedText.append(Text(token).foregroundColor(.init(uiColor: color)))
	 }

	 mutating func addPlainText(_ text: String) {
		self.accumulatedText.append(
		  Text(text).foregroundColor(.init(uiColor: self.theme.plainTextColor))
		)
	 }

	 mutating func addWhitespace(_ whitespace: String) {
		self.accumulatedText.append(Text(whitespace))
	 }

	 func build() -> Text {
		self.accumulatedText.reduce(Text(""), +)
	 }
  }
}

