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

    @Query(sort: \VimModel.name)
    var models: [VimModel]

    @State
    var model: VimModel?

    var body: some View {
        NavigationSplitView {
            List(models, selection: $model) { model in
                navigationLink(for: model)
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

    /// Builds a navigation link for the specified model
    /// - Parameter model: the model to build a link for
    /// - Returns: a NavigationLink
    private func navigationLink(for model: VimModel) -> some View {
        NavigationLink(value: model) {
            VimModelRow(model: model)
        }
    }

    private func handleModelChange() {
        guard let model else { return }
        debugPrint("🚀", model.name)
    }
}

#Preview {
    VimModelList()
        .modelContainer(VimModelContainer.shared.modelContainer)
}
