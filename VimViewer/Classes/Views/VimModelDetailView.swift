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
            switch vim.state {
            case .loading, .downloading:
                ProgressView()
                    .controlSize(.large)
            case .ready:
                readyView
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

    var readyView: some View {

        VStack {

            HStack {

                Image(file: model.previewImageName)?
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.blue, lineWidth: 4)
                    }
                    .padding([.leading, .trailing])


                Text(model.name)
                    .font(.title)

                Spacer()

                Button {
                    launchViewer()
                } label: {
                    Image(systemName: "cube")
                }
                .controlSize(.extraLarge)
            }


            Divider()

            VimHeaderView()

        }.padding()
    }

    private func launchViewer() {
        debugPrint("🚀")
        Task {
            await vim.geometry?.load()
        }
    }
}

#Preview {
    let model = VimModelContainer.mocks.first!
    let vim: Vim = .init()
    VimModelDetailView(model: model).environmentObject(vim)
}
