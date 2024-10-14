//
//  ImmersiveSpace+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee on 10/14/24.
//

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
