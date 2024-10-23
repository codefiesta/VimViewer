//
//  VimModelDetailView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
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

    var model: VimModelDescriptor

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
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $presentRenderer) {
            rendererView
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

                launchButton
            }


            Divider()

            VimHeaderView()

        }.padding()
    }

    /// The iOS specific model renderer.
    #if os(iOS)
    var rendererView: some View {
        NavigationStack {
            VimRendererView()
                .toolbar {
                    Button {
                        presentRenderer.toggle()
                    } label: {
                        Image(systemName: "xmark")
                        .renderingMode(.template)
                    }
                    .buttonStyle(.plain)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle(model.name)
                }
        }
    }
    #endif

    private var launchButton: some View {
        Button {
            launchViewer()
        } label: {
            Image(systemName: "cube")
        }
        .controlSize(.extraLarge)
    }

    /// Launches the model viewer.
    private func launchViewer() {
        loadGeometry()
        #if os(macOS)
        openWindow(id: .renderer)
        #else
        presentRenderer.toggle()
        #endif
    }

    /// Loads the geometry (if needed)
    private func loadGeometry() {
        Task {
            switch vim.geometry?.state {
            case .none:
                break
            case .some(.unknown), .some(.error(_)):
                // Only load the geometry if needed
                await vim.geometry?.load()
            case .some(.loading), .some(.indexing), .some(.ready):
                break
            }
        }
    }
}

#Preview {
    let model = ModelContainer.mocks.first!
    let vim: Vim = .init()
    VimModelDetailView(model: model).environmentObject(vim)
}
