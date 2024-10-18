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

    @Query(sort: \VimModel.name)
    var models: [VimModel]

    @State
    var model: VimModel?

    var body: some View {
        NavigationSplitView {
            List(models, selection: $model) { model in
                NavigationLink(value: model) {
                    VimModelRowView(model: model)
                }
            }
            .navigationDestination(item: $model) { model in
                VimModelDetailView(model: model)
            }
        } detail: {
            Text("Select a Model")
        }
        .onChange(of: model) { _, _ in
            Task {
                await handleModelChange()
            }
        }
    }

    /// Handles a model selection change event.
    private func handleModelChange() async {
        guard let model else { return }
        let loadTask = Task {
            // Load the file
            await vim.load(from: model.url)
            // Update the preview image
            if model.previewImageName == nil {
                model.previewImageName = vim.assets?.previewImageName
            }
        }
        // Wait for the file to be loaded
        await _ = loadTask.value
        Task {
            // Start the db import process
            await vim.db?.import()
        }
    }
}

#Preview {
    VimModelListView()
        .modelContainer(VimModelContainer.shared.modelContainer)
}
