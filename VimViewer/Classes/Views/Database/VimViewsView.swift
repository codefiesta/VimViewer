//
//  VimViewsView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimViewsView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Environment(\.modelContext)
    var modelContext

    @Query(sort: \Database.View.index)
    var allViews: [Database.View]

    /// The in-memory filtered results
    var views: [Database.View] {
        guard searchText.isNotEmpty else { return allViews }
        return allViews.filter{ $0.element?.name?.lowercased().contains(searchText.lowercased()) ?? true}
    }

    @State
    var searchText: String = .empty

    @State
    var isExpanded: Bool = false

    var body: some View {
        List {
            ForEach(views) { view in
                Button {
                    onViewTap(view: view)
                } label: {
                    Text(view.element?.name ?? .empty)
                }
            }
        }
        .navigationTitle("Views")
        #if !os(macOS)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        #endif
        .onChange(of: searchText, { oldValue, newValue in
            isExpanded = newValue.isNotEmpty
        })
    }

    /// Handles a view tap even.
    /// - Parameter view: the view that was selected.
    private func onViewTap(view: Database.View) {
        vim.camera.look(in: view.direction, from: view.position)
        viewModel.sheetFocus = .none
    }
}

#Preview {
    VimViewsView()
}
