//
//  VimModelList.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimModelList: View {

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
                    VimModelRow(model: model)
                }
            }
            .navigationDestination(item: $model) { model in
                VimModelDetail(model: model)
            }
        } detail: {
            Text("Select a Model")
        }
        .onChange(of: model) { _, _ in
            handleModelChange()
        }
    }

    /// Handles a model selection change event.
    private func handleModelChange() {
        guard let model else { return }
        Task {
            await vim.load(from: model.url)

            if model.previewImageName == nil {
                model.previewImageName = vim.assets?.previewImageName
            }
        }
    }
}

#Preview {
    VimModelList()
        .modelContainer(VimModelContainer.shared.modelContainer)
}
