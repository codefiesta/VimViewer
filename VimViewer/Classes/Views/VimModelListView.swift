//
//  VimModelListView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimListView: View {

    @Query(sort: \VimModel.name)
    var models: [VimModel]

    @FocusedBinding(\.focusedModelBinding)
    var model: VimModel?

    var body: some View {
        NavigationSplitView {
            List(models, selection: $model) { model in
                navigationLink(for: model)
            }
        } detail: {
            Text("Select a Model")
        }
        .focusedValue(model)
    }

    /// Builds a navigation link for the specified model
    /// - Parameter model: the model to build a link for
    /// - Returns: a NavigationLink
    private func navigationLink(for model: VimModel) -> some View {
        NavigationLink {
            Text(model.name)
                .navigationTitle(model.name)
        } label: {
            VimModelRow(model: model)
        }
    }
}

#Preview {
    VimListView()
        .modelContainer(VimModelContainer.shared.modelContainer)
}
