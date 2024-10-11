//
//  VimModelListView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI

struct VimListView: View {

    @Query(sort: \VimModel.name)
    var models: [VimModel]

    @FocusedValue(\.focusedModel)
    var model: VimModel?

    var body: some View {

        @FocusedBinding(\.focusedModelBinding)
        var model: VimModel?

        NavigationSplitView {

            List(selection: $model) {
                ForEach(models, id: \.self) { model in
                    NavigationLink {
                        VStack {
                            Text(model.name)
                                .navigationTitle(model.name)
                        }
                    } label: {
                        VimModelRow(model: model)
                    }
                }
            }
        } detail: {
            Text("Select a Model")
        }
        .focusedValue(model)
    }
}

#Preview {
    VimListView().modelContainer(VimModelContainer.shared.modelContainer)
}
