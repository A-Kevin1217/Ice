//
//  AboutSettingsPane.swift
//  Ice
//

import SwiftUI

struct AboutSettingsPane: View {
    @Environment(\.openURL) private var openURL
    @State private var frame = CGRect.zero

    private var acknowledgementsURL: URL {
        // swiftlint:disable:next force_unwrapping
        Bundle.main.url(forResource: "Acknowledgements", withExtension: "pdf")!
    }

    private var contributeURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "https://github.com/jordanbaird/Ice")!
    }

    private var issuesURL: URL {
        contributeURL.appendingPathComponent("issues")
    }

    private var donateURL: URL {
        // swiftlint:disable:next force_unwrapping
        URL(string: "https://icemenubar.app/Donate")!
    }

    private var minFrameDimension: CGFloat {
        min(frame.width, frame.height)
    }

    var body: some View {
        HStack {
            if let nsImage = NSImage(named: NSImage.applicationIconName) {
                Image(nsImage: nsImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: minFrameDimension / 1.5)
            }

            VStack(alignment: .leading) {
                Text("Ice")
                    .font(.system(size: minFrameDimension / 7))
                    .foregroundStyle(.primary)

                HStack(spacing: 4) {
                    Text("Version")
                    Text(Constants.appVersion)
                }
                .font(.system(size: minFrameDimension / 30))
                .foregroundStyle(.secondary)

                Text(Constants.copyright)
                    .font(.system(size: minFrameDimension / 37))
                    .foregroundStyle(.tertiary)
                Text("简体中文 汉化：小丞")
                    .font(.system(size: minFrameDimension / 37))
                    .foregroundStyle(.tertiary)
            }
            .fontWeight(.medium)
            .padding([.vertical, .trailing])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onFrameChange(update: $frame)
        .bottomBar {
            HStack {
                Button(LocalizedStringKey("Quit Ice")) {
                    NSApp.terminate(nil)
                }
                Spacer()
                Button(LocalizedStringKey("Acknowledgements")) {
                    NSWorkspace.shared.open(acknowledgementsURL)
                }
                Button(LocalizedStringKey("Contribute")) {
                    openURL(contributeURL)
                }
                Button(LocalizedStringKey("Report a Bug")) {
                    openURL(issuesURL)
                }
                Button {
                    openURL(donateURL)
                } label: {
                    Label(
                        LocalizedStringKey("Support Ice"),
                        systemImage: "heart.circle.fill"
                    )
                }
            }
            .padding()
        }
    }
}
