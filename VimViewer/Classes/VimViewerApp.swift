//
//  VimViewerApp.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit
#if os(visionOS)
import VimKitCompositor
#endif

@main
struct VimViewerApp: App {

    @Environment(\.vim)
    var vim: Vim

    let modelContainer = VimModelContainer.shared.modelContainer

    var body: some Scene {
        WindowGroup {
            VimContentView()
        }
        .environmentObject(vim)
        .modelContainer(modelContainer)

        #if !os(visionOS)
        WindowGroup(id: .renderer) {
            VimRendererContainerView(vim: vim)
        }
        .environmentObject(vim)
        .modelContainer(modelContainer)
        #else
        ImmersiveSpace(id: .renderer) {
            VimImmersiveSpaceContent(vim: vim, configuration: .init(), dataProviderContext: .init())
        }
        #endif

    }
}
