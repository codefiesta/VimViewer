//
//  VimInstanceInspectorView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

enum PropertySelectionScope: Int, Identifiable, CaseIterable {

    var id: Int { return rawValue }

    case instance, type

    var displayName: String {
        switch self {
        case .instance:
            return "Instance Properties"
        case .type:
            return "Type Properties"
        }
    }
}

struct VimInstanceInspectorView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Environment(\.modelContext)
    var modelContext

    @State
    var propertyScope: PropertySelectionScope = .instance

    /// The database element associated with the currently selected instance id.
    @State
    var element: Database.Element?

    @State
    var isDisclosed: Bool = false

    /// The instance id.
    var id: Int

    /// Common Initializer
    /// - Parameter id: the instance id
    init?(id: Int?) {
        guard let id else { return nil }
        self.id = id
    }

    var body: some View {

        VStack(spacing: 4) {

            HStack(alignment: .bottom, spacing: 16) {
                inspectButton
                hideButton
                hideSimilarButton
                sectionButton
            }

            VimElementView(element: element)


            VStack {
                Picker(.empty, selection: $propertyScope) {
                    ForEach(PropertySelectionScope.allCases, id: \.self) { scope in
                        Text(scope.displayName)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                VimElementParametersView(scope: propertyScope, element: element)

            }
            .frame(height: isDisclosed ? nil : 0, alignment: .top)
            .clipped()
        }
        .padding()
        .background(Color.black.opacity(0.65))
        .cornerRadius(8)
        .onAppear {
            load()
        }
    }

    var hideButton: some View {
        Button {
            Task {
                await vim.hide(ids: [id])
            }
        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "eye.slash")
                Text("Hide").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var hideSimilarButton: some View {
        Button {
            hideSimilar()
        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "eye.slash.fill")
                Text("Similar").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var inspectButton: some View {
        Button {
            withAnimation {
                isDisclosed.toggle()
            }
        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "info.circle")
                Text("Inspect").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var sectionButton: some View {
        Button {
            applySectionBox()
        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "square.arrowtriangle.4.outward")
                Text("Section").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    /// Loads the selected instance element data from the database.
    private func load() {
        let index = Int64(id)
        let predicate = #Predicate<Database.Node>{ $0.index == index }
        var fetchDescriptor = FetchDescriptor<Database.Node>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        guard let results = try? modelContext.fetch(fetchDescriptor), results.isNotEmpty else { return
        }
        element = results.first?.element
    }

    /// Hides similar instances to the currently selected instance.
    /// The logic is to hide all instances that are in the same family.
    private func hideSimilar() {
        guard let element, let familyName = element.familyName else { return }

        let predicate = #Predicate<Database.Node>{ $0.element?.familyName == familyName }
        let fetchDescriptor = FetchDescriptor<Database.Node>(predicate: predicate)
        guard let results = try? modelContext.fetch(fetchDescriptor), results.isNotEmpty else { return
        }
        let ids = results.compactMap{ Int($0.index) }
        Task {
            await vim.hide(ids: ids)
        }
    }

    /// Applies a section box to this instance.
    private func applySectionBox() {
        guard let geometry = vim.geometry, let instance = geometry.instance(id: id) else { return }
        let clipPlanes = instance.boundingBox.planes
        _ = geometry.select(id: id)
        vim.camera.clipPlanes = clipPlanes
    }
}

#Preview {
    let vim: Vim = .init()
    VimInstanceInspectorView(id: 0)
        .environmentObject(vim)
        .environment(VimViewModel())
}
