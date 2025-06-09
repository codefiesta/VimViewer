//
//  VimElementParametersView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimElementParametersView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Environment(\.modelContext)
    var modelContext

    @State
    var instanceParameters: [String: [Database.Parameter]] = [:]

    @State
    var typeParameters: [String: [Database.Parameter]] = [:]

    @State
    var textureFile: String?

    var scope: PropertySelectionScope
    var element: Database.Element

    var groups: [String: [Database.Parameter]] {
        switch scope {
        case .instance:
            instanceParameters
        case .type:
            typeParameters
        }
    }

    var keys: [String] {
        groups.keys.sorted { $0 > $1 }
    }

    init?(scope: PropertySelectionScope, element: Database.Element?) {
        guard let element else { return nil }
        self.scope = scope
        self.element = element
    }

    var body: some View {
        List {
            // Show the material in the list
            if scope == .instance, let image = vim.assets?.image(from: textureFile) {
                Section("Material") {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(maxHeight: 80)
                        .scaledToFill()
                }
            }
            // The scoped properties
            ForEach(keys, id: \.self) { key in
                Section(header: Text(key)) {
                    ForEach(groups[key] ?? []) { parameter in
                        HStack {
                            Text(parameter.descriptor?.name ?? .empty).bold()
                            Text(parameter.formattedValue)
                        }
                    }
                }
            }
        }
        .onChange(of: scope) { oldValue, newValue in
            // TODO: Scroll to the top of the list
        }
        .onAppear {
            fetch()
        }
    }

    /// Fetches all data for the view.
    private func fetch() {
        fetchInstanceParameters()
        fetchTypeParameters()
        fetchMaterial()
    }

    /// Fetches the instance parameters.
    private func fetchInstanceParameters() {
        let index = element.index
        let predicate = #Predicate<Database.Parameter> {
            return $0.element == index
        }
        let fetchDescriptor = FetchDescriptor<Database.Parameter>(predicate: predicate)
        guard let results = try? modelContext.fetch(fetchDescriptor), results.isNotEmpty else { return }

        var groups = [String: [Database.Parameter]]()
        for parameter in results {
            guard let descriptor = parameter.descriptor else { continue }
            if groups[descriptor.group] != nil {
                groups[descriptor.group]?.append(parameter)
            } else {
                groups[descriptor.group] = [parameter]
            }
        }
        instanceParameters = groups
    }

    /// Fetches the instance type parameters.
    private func fetchTypeParameters() {
        guard let instanceType = element.instanceType else { return }
        let index = instanceType.index
        let predicate = #Predicate<Database.Parameter> {
            return $0.element == index
        }
        let fetchDescriptor = FetchDescriptor<Database.Parameter>(predicate: predicate)
        guard let results = try? modelContext.fetch(fetchDescriptor), results.isNotEmpty else { return }

        var groups = [String: [Database.Parameter]]()
        for parameter in results {
            guard let descriptor = parameter.descriptor else { continue }
            if groups[descriptor.group] != nil {
                groups[descriptor.group]?.append(parameter)
            } else {
                groups[descriptor.group] = [parameter]
            }
        }
        typeParameters = groups
    }

    /// Fetches the element material
    private func fetchMaterial() {
        let index = element.index
        let predicate = #Predicate<Database.MaterialInElement>{ $0.element?.index == index }
        let fetchDescriptor = FetchDescriptor<Database.MaterialInElement>(predicate: predicate)
        guard let results = try? modelContext.fetch(fetchDescriptor), results.isNotEmpty else { return }
        guard let material = results.first?.material else { return }
        textureFile = material.colorTextureFile?.bufferName
    }
}

#Preview {
    VimElementParametersView(scope: .instance, element: .init())
}
