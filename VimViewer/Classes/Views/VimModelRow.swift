//
//  VimModelRow.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimModelRow: View {

    var model: VimModel

    var isCached: Bool {
        model.url.isCached
    }

    var cacheStatusIcon: String {
        isCached ? "checkmark.icloud" : "icloud.and.arrow.down"
    }

    var cacheStatusColor: Color {
        isCached ? .green : .secondary
    }

    var cacheFileSize: String {
        isCached ? model.url.cacheSizeFormatted : "Unknown"
    }

    var body: some View {

        HStack {
            Image(.empty)
                .resizable()
                .background(Color.random)
                .frame(width: 50, height: 50)
                .cornerRadius(5)

            VStack(alignment: .leading) {
                Text(model.name)
                    .bold()
                Text(cacheFileSize)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: cacheStatusIcon)
                .symbolRenderingMode(.palette)
                .foregroundStyle(
                    cacheStatusColor,
                    Color.primary
                )
                .font(.title)

        }
    }
}

#Preview {
    VimModelRow(model: VimModelContainer.mocks.first!)
}
