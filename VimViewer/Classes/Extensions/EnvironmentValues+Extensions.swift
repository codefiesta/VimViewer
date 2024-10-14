//
//  EnvironmentValues+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit
#if os(visionOS)
import VimKitCompositor
#endif

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

#if os(visionOS)

public extension EnvironmentValues {

    /// Exposes `@Environment(\.dataProvider) var dataProvider` to Views.
    var dataProvider: ARDataProvider {
        get { self[ARDataProviderKey.self] }
        set { self[ARDataProviderKey.self] = newValue }
    }
}

struct ARDataProviderKey: EnvironmentKey {

    /// The default ARDataProvider
    static let defaultValue: ARDataProvider = .init()
}

#endif
