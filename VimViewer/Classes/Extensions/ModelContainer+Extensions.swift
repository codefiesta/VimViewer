//
//  ModelContainer+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData

private let models: [any PersistentModel.Type] = [
    VimModelDescriptor.self
]

extension ModelContainer {

    /// The default application model container.
    static let `default`: ModelContainer = {

        let isStoredInMemoryOnly = true

        let schema: Schema = .init(models)
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)
        guard let container = try? ModelContainer(for: schema, configurations: [configuration]) else {
            fatalError("💩 Unabled to create ModelContainer")
        }

        #if DEBUG
        // Insert mock data
        let modelContext: ModelContext = ModelContext(container)
        for mock in mocks {
            modelContext.insert(mock)
        }
        #endif
        return container
    }()

}
