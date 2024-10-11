//
//  VimListView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI

struct VimListView: View {

    @Query(sort: \VimDataModel.name)
    var models: [VimDataModel]

    @FocusedValue(\.focusedModel)
    var focusedModel: VimDataModel?

    var body: some View {

        @FocusedBinding(\.focusedModelBinding)
        var model: VimDataModel?

        NavigationSplitView {

            List(selection: $model) {
                ForEach(models, id: \.self) { model in
                    NavigationLink {
                        VStack {
                            Text(model.name)
                                .navigationTitle(model.name)
                        }
                    } label: {
                        Text(model.name)
                    }
                }
            }
        } detail: {
            Text("Select a Model")
        }
        .focusedValue(focusedModel)
    }
}

#Preview {
    VimListView().modelContainer(VimModelContainer.shared.modelContainer)
}
