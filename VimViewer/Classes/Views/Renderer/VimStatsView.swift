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

    /// Returns the colors for their corresponding range
    private var colors: [Color] {
        [
            .red,
            .orange,
            .yellow,
            .green
        ]
    }

    /// Returns the ranges of culling percengtages.
    private var ranges: [Range<Float>] {
        [
            0.0..<0.25,
            0.25..<0.5,
            0.5..<0.75,
            0.75..<1.0
        ]
    }

    /// Returns the culling percentage color.
    var cullingPercentageColor: Color {
        guard vim.stats.cullingPercentage > .zero else {
            return .primary
        }

        for (i, range) in ranges.enumerated() {
            if range.contains(vim.stats.cullingPercentage) {
                return colors[i]
            }
        }
        return .primary
    }

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
            HStack(spacing: 0) {
                Text("Culling:")
                Text(" \(vim.stats.cullingPercentage.formatted(.percent.precision(.fractionLength(1))))").foregroundStyle(cullingPercentageColor)
            }
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
