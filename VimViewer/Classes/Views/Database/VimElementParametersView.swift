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
    var textureFile: String?

    var scope: PropertySelectionScope
    var element: Database.Element

    /// Returns the grouped paramaters based on the current scope.
    var parameters: [String: [Database.Parameter]] {
        switch scope {
        case .instance:
            element.instanceParameters
        case .type:
            element.instanceType?.instanceParameters ?? [:]
        }
    }

    var keys: [String] {
        parameters.keys.sorted { $0 > $1 }
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
                    ForEach(parameters[key] ?? []) { parameter in
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
            fetchMaterial()
        }
    }

    /// Loads the element material
    private func fetchMaterial() {
        let index: Int64? = element.index
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
