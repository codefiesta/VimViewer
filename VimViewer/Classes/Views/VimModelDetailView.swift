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

    @Environment(\.openWindow)
    var openWindow

    @Environment(\.dismissWindow)
    private var dismissWindow

    #if os(visionOS)
    @Environment(\.openImmersiveSpace)
    var openImmersiveSpace

    @Environment(\.dismissImmersiveSpace)
    var dismissImmersiveSpace

    #endif

    @State
    var presentRenderer: Bool = false

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
                .padding()
        }
        .navigationTitle(model.name)
        #if os(iOS)
        .fullScreenCover(isPresented: $presentRenderer) {
            VimRendererContainerView(vim: vim)
        }
        #elseif os(visionOS)
        .onChange(of: presentRenderer) { _, newValue in
            Task { @MainActor in
                if newValue {
                    await openImmersiveSpace(id: .renderer)
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
        #endif
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
        #if os(macOS)
        openWindow(id: .renderer)
        #else
        presentRenderer.toggle()
        #endif
    }
}

#Preview {
    let model = VimModelContainer.mocks.first!
    let vim: Vim = .init()
    VimModelDetailView(model: model).environmentObject(vim)
}
