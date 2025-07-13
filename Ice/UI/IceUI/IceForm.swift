//
//  IceForm.swift
//  Ice
//

import SwiftUI

struct IceForm<Content: View>: View {
    @State private var contentFrame = CGRect.zero

    private let alignment: HorizontalAlignment
    private let padding: EdgeInsets
    private let spacing: CGFloat
    private let content: Content

    init(
        alignment: HorizontalAlignment = .center,
        padding: EdgeInsets,
        spacing: CGFloat = 10,
        @ViewBuilder content: () -> Content
    ) {
        self.alignment = alignment
        self.padding = padding
        self.spacing = spacing
        self.content = content()
    }

    init(
        alignment: HorizontalAlignment = .center,
        padding: CGFloat = 20,
        spacing: CGFloat = 10,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            alignment: alignment,
            padding: EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding),
            spacing: spacing
        ) {
            content()
        }
    }

    var body: some View {
        GeometryReader { geometry in
            if contentFrame.height > geometry.size.height {
                ScrollView {
                    contentStack
                }
                .scrollContentBackground(.hidden)
            } else {
                contentStack
            }
        }
    }

    private var contentStack: some View {
        _VariadicView.Tree(IceFormLayout(spacing: spacing)) {
            content
        }
        .padding(padding)
        .background(GeometryReader { geometry in
            Color.clear.preference(
                key: FramePreferenceKey.self,
                value: geometry.frame(in: .local)
            )
        })
        .onPreferenceChange(FramePreferenceKey.self) { frame in
            contentFrame = frame
        }
    }
}

private struct IceFormLayout: _VariadicView_UnaryViewRoot {
    let spacing: CGFloat

    @ViewBuilder
    func body(children: _VariadicView.Children) -> some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(children) { child in
                child
            }
        }
    }
}

private struct IceFormToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            configuration.isOn ? Image(systemName: "checkmark") : nil
        }
        .contentShape(Rectangle())
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
