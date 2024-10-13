//
//  EnvironmentValues+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

public extension EnvironmentValues {

    /// Exposes `@Environment(\.vim) var vim` to Views.
    var vim: Vim {
        get { self[VimKey.self] }
        set { self[VimKey.self] = newValue }
    }
}

struct VimKey: EnvironmentKey {

    /// The default vim instance that is loaded into the environment.
    static let defaultValue: Vim = .init()
}
