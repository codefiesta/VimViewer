//
//  VimTreeView.swift
//  VimViewer
//
//  Created by Kevin McKee on 4/1/25.
//

import SwiftData
import SwiftUI
import VimKit

struct VimTreeView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Environment(\.modelContext)
    var modelContext

    @State
    var modelTree: Database.ModelTree = .init()

    @State
    var searchText: String = .empty

    @State
    var isExpanded: Bool = false

    var body: some View {
        List {
            if modelTree.categories.isEmpty {
                ProgressView()
            } else {
                ForEach(modelTree.categories) { category in
                    DisclosureGroup(
                        content: {
                            families(category)
                        },
                        label: {
                            Text(category)
                                .padding()
                                .font(.title2)
                        }
                    )

                }
            }
        }
        .navigationTitle(modelTree.title)
        #if !os(macOS)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        #endif
        .onChange(of: searchText, { oldValue, newValue in
        })
        .task {
            await modelTree.load(modelContext: modelContext)
        }
    }

    /// Builds the disclosure group for all of the families in the specifed category
    /// - Parameter category: the cateogry name
    /// - Returns: the list of disclosure groups for the specifed category
    func families(_ category: String) -> some View {
        ForEach(modelTree.families(in: category)) { family in
            DisclosureGroup(
                content: {
                    types(family)
                },
                label: {
                    Text(family)
                        .padding()
                        .font(.title2)
                }
            )
        }
    }

    func types(_ family: String) -> some View {
        ForEach(modelTree.types(in: family)) { type in
            DisclosureGroup(
                content: {
                    instances(type)
                },
                label: {
                    Text(type)
                        .padding()
                        .font(.title2)
                }
            )
        }
    }

    func instances(_ type: String) -> some View {
        ForEach(modelTree.instances(in: type), id: \.id) { id in
            HStack {
                Text("[\(id.formatted(.plain))] \(type)")

                Spacer()

                Button(action: {
                    applySectionBox(id: id)
                }, label: {
                    VStack(alignment: .center, spacing: 8) {
                        Image(systemName: "square.arrowtriangle.4.outward")
                        Text("Section").font(.caption2)
                    }
                })
                .buttonStyle(.plain)

            }
            .padding()
            .font(.title2)
        }
    }

    /// Applies a section box around selected instance.
    /// - Parameter id: the element ID
    func applySectionBox(id: Int64) {
        guard let geometry = vim.geometry else { return }
        // Map the id back to the node index
        guard let index = modelTree.elementNodes[id] else { return }
        let id = Int(index)
        guard let instance = geometry.instance(id: id) else { return }
        // Zoom to the box extents and add clip planes around it
        vim.camera.zoom(to: instance.boundingBox, clip: true)
        // Dismiss the sheet
        viewModel.sheetFocus = .none
    }

}

#Preview {
    VimTreeView()
}
