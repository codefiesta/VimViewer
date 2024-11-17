//
//  VimStatsView.swift
//  VimViewer
//
//  Created by Kevin McKee on 11/8/24.
//

import SwiftUI
import VimKit

struct VimStatsView: View {

    @EnvironmentObject
    var vim: Vim

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Geometry")
                .font(.headline)
            Text("Instances: \(vim.stats.instanceCount)")
            Text("Meshes: \(vim.stats.meshCount)")
            Text("Submeshes: \(vim.stats.submeshCount)")
            Divider()
            Text("Stats:")
                .font(.headline)
            Text("Commands: \(vim.stats.executedCommands) / \(vim.stats.totalCommands)")
            Text("Culling: \(vim.stats.cullingPercentage.formatted(.percent.precision(.fractionLength(1))))")
            Divider()
            Text("Latency")
                .font(.headline)
            HStack {
                Text("Mean: \(vim.stats.averageLatency.formatted(.default))")
                Text("Max: \(vim.stats.maxLatency.formatted(.default))")
            }
            .font(.caption)
        }
        .font(.caption)
        .fixedSize()
        .padding()
        .background(Color.black.opacity(0.65))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white, lineWidth: 2)
        )    }
}

#Preview {
    let vim: Vim = .init()


    VimStatsView()
        .environmentObject(vim)
}
