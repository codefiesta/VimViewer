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

    #if os(visionOS)

    @Environment(\.dataProvider)
    var dataProvider: ARDataProvider

    #endif

    let modelContainer = VimModelContainer.shared.modelContainer

    var body: some Scene {

        WindowGroup {
            VimMainContentView()
            .task {
                await runStartupTasks()
            }
        }
        .environmentObject(vim)
        .modelContainer(modelContainer)

        #if os(visionOS)

        // If we are running visionOS, build the immersive space
        ImmersiveSpace(id: .renderer) {
            VimImmersiveSpaceContent(vim: vim, dataProvider: dataProvider)
        }

        #else

        // If we are running macOS or iOS build the renderer window group
        WindowGroup(id: .renderer) {
            VimRendererContainerView(vim: vim)
        }
        .environmentObject(vim)
        .modelContainer(modelContainer)

        #endif
    }

    /// Runs any application startup tasks.
    private func runStartupTasks() async {
        #if os(visionOS)
        await dataProvider.start()
        #endif
    }
}
