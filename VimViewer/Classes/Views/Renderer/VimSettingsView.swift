//
//  VimSettingsView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimSettingsView: View {

    @EnvironmentObject
    var vim: Vim

    @State
    var enableWireFrame: Bool = false

    @State
    var enableDepthTesting: Bool = false

    @State
    var enableContributionTesting: Bool = false

    var body: some View {
        List {
            Section("Render Mode") {
                Toggle(isOn: $enableWireFrame) {
                    Text("Wireframe")
                }
            }
            Section("Culling") {
                Toggle(isOn: $enableDepthTesting) {
                    Text("Depth Testing")
                }
                Toggle(isOn: $enableContributionTesting) {
                    Text("Contribution Area Testing")
                }
            }
        }
        .navigationTitle("Settings")
        .onChange(of: enableWireFrame) { _, newValue in
            vim.options.wireFrame = newValue
        }
        .onChange(of: enableDepthTesting) { _, newValue in
            vim.options.enableDepthTesting = newValue
        }
        .onChange(of: enableContributionTesting) { _, newValue in
            vim.options.enableContributionTesting = newValue
        }
        .onAppear {
            enableWireFrame = vim.options.wireFrame
            enableDepthTesting = vim.options.enableDepthTesting
            enableContributionTesting = vim.options.enableContributionTesting
        }
    }
}

#Preview {
    VimSettingsView()
}
