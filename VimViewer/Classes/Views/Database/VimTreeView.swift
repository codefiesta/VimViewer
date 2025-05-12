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
                            categoryRow(category: category)
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

            guard let nodes = vim.db?.nodes else { return }
            await modelTree.load(modelContext: modelContext, nodes: nodes)
        }
    }

    /// Builds the category row view.
    /// - Parameter category: the category name
    /// - Returns: the category row view
    func categoryRow(category: String) -> some View {
        HStack {
            Text(category)
                .padding()
                .font(.title2)
            Spacer()
            Button(action: {
                isolate(category: category)
            }, label: {
                Image(systemName: "scope")
            })
        }
        .buttonStyle(.plain)
    }

    /// Builds the family row view.
    /// - Parameter family: the family name
    /// - Returns: the family row view
    func familyRow(family: String) -> some View {
        HStack {
            Text(family)
                .padding()
                .font(.title2)
            Spacer()
            Button(action: {
                isolate(family: family)
            }, label: {
                Image(systemName: "scope")
            })
            .buttonStyle(.plain)
        }
    }

    /// <#Description#>
    /// - Parameter type: <#type description#>
    /// - Returns: <#description#>
    func typeRow(type: String) -> some View {
        HStack {
            Text(type)
                .padding()
                .font(.title2)
            Spacer()
            Button(action: {
                isolate(type: type)
            }, label: {
                Image(systemName: "scope")
            })
            .buttonStyle(.plain)
        }
    }

    /// Builds a rows for an instance with the specified type and id.
    /// - Parameters:
    ///   - type: the instance type
    ///   - id: the instance id
    /// - Returns: an instance row for the specfied type and instance id
    func instanceRow(type: String, id: Int64) -> some View {
        HStack {
            Text("[\(id.formatted(.plain))] \(type)")
                .padding()
                .font(.title2)

            Spacer()

            Button(action: {
                isolate(id: id)
            }, label: {
                Image(systemName: "scope")
            })
            .buttonStyle(.plain)

        }
        .padding()
        .font(.title2)
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
                    familyRow(family: family)
                }
            )
        }
    }

    /// Builds the disclosure group for all of the types in the specifed family
    /// - Parameter family: the family name
    /// - Returns: the list of disclosure groups for the specifed family
    func types(_ family: String) -> some View {
        ForEach(modelTree.types(in: family)) { type in
            DisclosureGroup(
                content: {
                    instances(type)
                },
                label: {
                    typeRow(type: type)
                }
            )
        }
    }

    /// Builds a list of instances rows the specified type.
    /// - Parameter type: the instance type
    /// - Returns: a list of instance rows
    func instances(_ type: String) -> some View {
        ForEach(modelTree.instances(in: type), id: \.id) { id in
            instanceRow(type: type, id: id)
        }
    }

    /// Isolates a speciifc instance.
    /// - Parameter id: the element ID
    func isolate(id: Int64) {
        guard let geometry = vim.geometry else { return }
        // Map the id back to the node index
        guard let index = modelTree.elementNodes[id] else { return }
        let id = Int(index)
        guard let instance = geometry.instance(id: id) else { return }
        Task {
            await vim.isolate(ids: [id])
        }
        // Zoom to the box extents
        vim.camera.zoom(to: instance.boundingBox, clip: false)

        // Dismiss the sheet
        viewModel.sheetFocus = .none
    }

    /// Isolates all nodes that match the specified cateogry
    /// - Parameter category: the category name
    func isolate(category: String) {
        let predicate = #Predicate<Database.Node>{
            if let element = $0.element, let cat = element.category {
                return cat.name == category
            } else {
                return false
            }
        }

        let descriptor = FetchDescriptor<Database.Node>(predicate: predicate, sortBy: [SortDescriptor(\.index)])
        guard let results = try? modelContext.fetch(descriptor), results.isNotEmpty else { return }
        let ids = results.compactMap{ Int($0.index) }
        Task {
            await vim.isolate(ids: ids)
        }
    }

    /// Isolates all nodes that match the family cateogry
    /// - Parameter family: the family name
    func isolate(family: String) {
        let predicate = #Predicate<Database.Node>{
            if let element = $0.element {
                return element.familyName == family
            } else {
                return false
            }
        }

        let descriptor = FetchDescriptor<Database.Node>(predicate: predicate, sortBy: [SortDescriptor(\.index)])
        guard let results = try? modelContext.fetch(descriptor), results.isNotEmpty else { return }
        let ids = results.compactMap{ Int($0.index) }
        Task {
            await vim.isolate(ids: ids)
        }
    }

    /// Isolates all nodes that match the type.
    /// - Parameter type: the instance type
    func isolate(type: String) {
        let predicate = #Predicate<Database.Node>{
            if let element = $0.element {
                return element.name == type
            } else {
                return false
            }
        }

        let descriptor = FetchDescriptor<Database.Node>(predicate: predicate, sortBy: [SortDescriptor(\.index)])
        guard let results = try? modelContext.fetch(descriptor), results.isNotEmpty else { return }
        let ids = results.compactMap{ Int($0.index) }
        Task {
            await vim.isolate(ids: ids)
        }
    }
}

#Preview {
    VimTreeView()
}
