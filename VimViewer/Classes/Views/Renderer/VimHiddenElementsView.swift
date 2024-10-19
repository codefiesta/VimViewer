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

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    var hiddenCount: Int {
        viewModel.hiddenCount
    }

    var isVisible: Bool {
        viewModel.hiddenCount > .zero
    }

    var body: some View {
        ZStack {
            if isVisible {
                HStack {
                    Text("\(hiddenCount) Hidden Objects")
                    Divider().overlay(.primary)
                    unhideButton
                }
                .fixedSize()
                .padding()
                .background(Color.black.opacity(0.65)).cornerRadius(8)
            }
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
    var viewModel: VimViewModel = .init()
    viewModel.hiddenCount = 10

    return VimHiddenElementsView()
        .environmentObject(vim)
        .environment(viewModel)
}
