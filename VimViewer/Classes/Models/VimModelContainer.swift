//
//  VimModelContainer.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData

private let models: [any PersistentModel.Type] = [
    VimModelDescriptor.self
]

class VimModelContainer {

    static let shared: VimModelContainer = VimModelContainer()

    var modelContainer: ModelContainer

    private init() {
        let schema: Schema = .init(models)
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        guard let modelContainer = try? ModelContainer(for: schema, configurations: [configuration]) else {
            fatalError("💩 Unabled to create ModelContainer")
        }
        self.modelContainer = modelContainer

        // Insert mock data
        let modelContext: ModelContext = ModelContext(modelContainer)
        let mocked: [VimModelDescriptor] = VimModelContainer.mocks
        for mock in mocked {
            modelContext.insert(mock)
        }
    }
}
