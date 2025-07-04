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

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    #if os(visionOS)

    @Environment(\.dataProvider)
    var dataProvider: ARDataProvider

    #endif

    var body: some Scene {

        WindowGroup {
            VimMainContentView()
            .task {
                await runStartupTasks()
            }
        }
        .environmentObject(vim)
        .environment(viewModel)
        .modelContainer(.default)

        #if os(visionOS)

        // If we are running visionOS, build the immersive space
        ImmersiveSpace(id: .renderer) {
            CompositorRendererImmersiveSpaceContent(vim: vim, dataProvider: dataProvider)
        }

        #elseif os(macOS)

        // If we are running macOS or iOS build the renderer window group
        WindowGroup(id: .renderer) {
            VimRendererView()
                .navigationTitle(viewModel.name)
        }
        .environmentObject(vim)
        .modelContainer(.default)
        .defaultPosition(.topLeading)

        #endif
    }

    /// Runs any application startup tasks.
    private func runStartupTasks() async {
        #if os(visionOS)
        await dataProvider.start()
        #endif
    }
}
