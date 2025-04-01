//
//  VimLevelsView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import simd
import SwiftData
import SwiftUI
import VimKit

struct VimLevelsView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Environment(\.modelContext)
    var modelContext

    @Query(sort: \Database.Level.elevation)
    var allLevels: [Database.Level]

    /// The in-memory filtered results
    var levels: [Database.Level] {
        guard searchText.isNotEmpty else { return allLevels }
        return allLevels.filter{ $0.element?.name?.lowercased().contains(searchText.lowercased()) ?? true}
    }

    @State
    var searchText: String = .empty

    var body: some View {
        List {
            ForEach(levels) { level in


                HStack(alignment: .top) {

                    VStack(alignment: .leading) {
                        Text(level.element?.name ?? .empty)
                            .font(.title2)
                        HStack {
                            Text("Elevation")
                            Text(level.elevation.formatted(.default))
                        }.font(.caption)
                    }

                    Spacer()

                    Button(action: {
                        onLevelButtonTap(level: level)
                    }, label: {
                        VStack(alignment: .center, spacing: 8) {
                            Image(systemName: "square.arrowtriangle.4.outward")
                            Text("Section").font(.caption2)
                        }
                    })
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Levels")
        #if !os(macOS)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        #endif
    }

    /// Handles a level tap even.
    /// - Parameter level: the level that was selected.
    private func onLevelButtonTap(level: Database.Level) {

        let elevation = level.elevation.singlePrecision
        let minBounds: SIMD3<Float> = .init(0, 0, elevation)

        let clipPlane: SIMD4<Float> = .init(.znegative, dot(.znegative, minBounds))
        vim.camera.clipPlanes[5] = clipPlane
        viewModel.sheetFocus = .none
    }
}

#Preview {
    VimLevelsView()
}
