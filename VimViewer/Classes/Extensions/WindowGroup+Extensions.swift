//
//  WindowGroup+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

extension WindowGroup {

    /// Convenience initializer that accepts a `VimSceneIdentifier`  as the identifier.
    /// - Parameters:
    ///   - id: the vim scene
    ///   - makeContent: the make content closure
    nonisolated init(id: VimSceneIdentifier, @ViewBuilder makeContent: @escaping () -> Content) {
        self.init(id: id.rawValue, makeContent: makeContent)
    }
}

extension OpenWindowAction {

    /// Convenience function that allows the application to open a window with a `VimSceneIdentifier`
    /// - Parameters:
    ///   - id: the vim scene identifier
    @MainActor @preconcurrency func callAsFunction(id: VimSceneIdentifier) {
        callAsFunction(id: id.rawValue)
    }
}
