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
        }

//        vim.url = model.url
//        debugPrint("🚀 \(vim.url)")
        //vim = .init(model.url)
//        Task {
//            await vim.download()
//        }
    }
}

#Preview {
    VimModelList()
        .modelContainer(VimModelContainer.shared.modelContainer)
}
