//
//  VimModelDetailView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimModelDetailView: View {

    @EnvironmentObject
    var vim: Vim
    var model: VimModel

    var body: some View {

        VStack {
            Text(model.name)
                .bold()

            Text("\(vim.state)")
                .bold()

            switch vim.state {
            case .loading, .downloading:
                ProgressView()
                    .controlSize(.large)
            case .ready:
                preview
            case .error, .unknown, .downloaded:
                EmptyView()
            }

            Spacer()
            Text(model.url.absoluteString)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .navigationTitle(model.name)
    }

    var preview: some View {
        VStack {
            if vim.state == .ready {
                VimHeaderView()
            }
        }
    }
}

#Preview {
    let model = VimModelContainer.mocks.first!
    let vim: Vim = .init()
    VimModelDetailView(model: model).environmentObject(vim)
}
