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
        VStack(alignment: .leading, spacing: 6) {
            Text("Culling Stats:")
                .bold()
            HStack {
                Text("\(vim.stats.executionRange.length)")
                Text("/")
                Text("\(vim.stats.commandRange.length)")
                Text("commands")
            }
            Divider()
                .overlay(.primary)
            Text("Latency:")
                .bold()
            HStack {
                Text("Mean: \(vim.stats.averageLatency.formatted(.default))")
                Text("Max: \(vim.stats.maxLatency.formatted(.default))")
            }
        }
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
