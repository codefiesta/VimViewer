//
//  VimHiddenElementsView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimHiddenElementsView: View {

    @EnvironmentObject
    var vim: Vim

    var count: Int

    init?(count: Int = .zero) {
        guard count > .zero else { return nil }
        self.count = count
    }

    var body: some View {
        ZStack {
            HStack {
                Text("\(count) Hidden Objects")
                Divider().overlay(.primary)
                unhideButton
            }
            .fixedSize()
            .padding()
            .background(Color.black.opacity(0.65)).cornerRadius(8)
        }
    }

    private var unhideButton: some View {
        Button {
            Task {
                await vim.unhide()
            }
        } label: {
            Text("Unhide")
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let vim: Vim = .init()
    VimHiddenElementsView(count: 1).environmentObject(vim)
}
