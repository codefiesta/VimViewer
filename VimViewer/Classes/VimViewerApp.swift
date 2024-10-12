//
//  VimViewerApp.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI

@main
struct VimViewerApp: App {

    let modelContainer = VimModelContainer.shared.modelContainer

    var body: some Scene {
        WindowGroup {
            VimContentView()
        }.modelContainer(modelContainer)
    }
}
