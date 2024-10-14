//
//  ImmersiveSpace+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee on 10/14/24.
//

#if os(visionOS)
import SwiftUI
import VimKit

/// Provides enum constants for application immersive spaces.
enum VimImmersiveSpace: String {

    /// The 3D model renderer
    case renderer
}

extension ImmersiveSpace {

    /// Convenience initializer that accepts a `VimImmersiveSpace` as an identifier.
    /// - Parameters:
    ///   - id: the vim immersive space
    ///   - content: the content builder.
    nonisolated init(id: VimImmersiveSpace, @ImmersiveSpaceContentBuilder content: () -> Content) where Data == Never {
        self.init(id: id.rawValue, content: content)
    }
}

extension OpenImmersiveSpaceAction {

    /// Convenience function that allows the application to open an immersive space by accepting a known `VimImmersiveSpace`
    /// - Parameters:
    ///   - id: the vim immersive space
    /// - Returns: the action result.
    @discardableResult
    @MainActor func callAsFunction(id: VimImmersiveSpace) async -> OpenImmersiveSpaceAction.Result {
        await callAsFunction(id: id.rawValue)
    }

}

#endif
