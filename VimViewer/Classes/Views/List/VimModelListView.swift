//
//  VimModelListView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimModelListView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Query(sort: \VimModelDescriptor.name)
    var models: [VimModelDescriptor]

    @State
    var selection: VimModelDescriptor?

    var body: some View {
        NavigationSplitView {
            List(models, selection: $selection) { model in
                NavigationLink(value: model) {
                    VimModelRowView(model: model)
                }
            }
            .navigationDestination(item: $selection) { model in
                VimModelDetailView(model: model)
            }
        } detail: {
            Text("Select a Model")
        }
        .onChange(of: selection) { _, _ in
            Task {
                await handleModelSelection()
            }
        }
    }

    /// Handles a model selection change event.
    private func handleModelSelection() async {
        guard let selection else { return }
        viewModel.descriptor = selection
        Task {
            // Load the file
            await vim.load(from: selection.url)
            // Update the preview image
            if selection.previewImageName == nil {
                selection.previewImageName = vim.assets?.previewImageName
            }
        }
    }
}

#Preview {
    VimModelListView()
        .modelContainer(.default)
}
