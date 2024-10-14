//
//  ImmersiveSpace+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee on 10/14/24.
//

#if os(visionOS)
import SwiftUI
import VimKit

extension ImmersiveSpace {

    /// Convenience initializer that accepts a `VimSceneIdentifier` as the id.
    /// - Parameters:
    ///   - id: the vim scene identifier
    ///   - content: the content builder.
    nonisolated init(id: VimSceneIdentifier, @ImmersiveSpaceContentBuilder content: () -> Content) where Data == Never {
        self.init(id: id.rawValue, content: content)
    }
}

extension OpenImmersiveSpaceAction {

    /// Convenience function that allows the application to open an immersive space with a known `VimSceneIdentifier`
    /// - Parameters:
    ///   - id: the vim scene identifier
    /// - Returns: the action result.
    @discardableResult
    @MainActor func callAsFunction(id: VimSceneIdentifier) async -> OpenImmersiveSpaceAction.Result {
        await callAsFunction(id: id.rawValue)
    }

}

#endif
