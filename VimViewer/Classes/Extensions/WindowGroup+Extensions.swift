//
//  WindowGroup+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

/// Provides contants for application window groups.
enum VimWindowGroup: String {

    /// The 3D model renderer
    case renderer
}

extension WindowGroup {

    /// Convenience initializer that accepts a `VimWindowGroup`
    /// - Parameters:
    ///   - id: the vim window group
    ///   - makeContent: the make content closure
    nonisolated init(id: VimWindowGroup, @ViewBuilder makeContent: @escaping () -> Content) {
        self.init(id: id.rawValue, makeContent: makeContent)
    }
}

extension OpenWindowAction {

    /// Convenience function that allows the application to open a window by accepting a known `VimWindowGroup`
    /// - Parameters:
    ///   - id: the vim window group
    @MainActor @preconcurrency func callAsFunction(id: VimWindowGroup) {
        callAsFunction(id: id.rawValue)
    }
}
