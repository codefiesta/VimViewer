//
//  View+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI

extension View {

    /// Provides a convenience extension that sets the model container and associated model context in this
    /// view's environment if the provided container is not null.
    /// - Parameters:
    ///   - container: The optional model container to use for this view.
    @MainActor @preconcurrency public func modelContainer(optional container: ModelContainer?) ->
    some View {
        guard let container else { return AnyView(self) }
        return AnyView(modelContainer(container))
    }
}
