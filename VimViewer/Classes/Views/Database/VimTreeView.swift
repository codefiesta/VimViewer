//
//  VimTreeView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimTreeView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @State
    var searchText: String = .empty

    var body: some View {
        List {
            if let tree = vim.tree {
                OutlineGroup(tree.root, id: \.name, children: \.children) { node in
                    nodeView(node)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(vim.tree?.root.name ?? .empty)
        #if !os(macOS)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        #endif
        .onChange(of: searchText, { oldValue, newValue in
        })
    }

    func nodeView(_ node: Vim.Tree.Node) -> some View {
        HStack {
            Text(node.name)
                .padding()
                .font(.title2)
            Spacer()
            if node.name != vim.tree?.root.name {
                Button(action: {
                    Task { @MainActor in
                        await vim.isolate(ids: node.ids)
                    }
                }, label: {
                    Image(systemName: "scope")
                })
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VimTreeView()
}
