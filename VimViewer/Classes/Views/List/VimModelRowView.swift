//
//  VimModelRow.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimModelRowView: View {

    @EnvironmentObject
    var vim: Vim

    var model: VimModelDescriptor

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

            previewImage

            VStack(alignment: .leading) {
                Text(model.name)
                    .bold()
                Text(cacheFileSize)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
            fileStatus
        }
    }

    var cacheStatusImage: some View {
        Image(systemName: cacheStatusIcon)
            .symbolRenderingMode(.palette)
            .foregroundStyle(cacheStatusColor, .primary)
            .font(.largeTitle)
    }

    var fileStatus: some View {
        HStack {
            if model.url == vim.url {
                switch vim.state {
                case .unknown, .ready, .downloaded:
                    cacheStatusImage
                case .downloading, .loading:
                    ProgressView()
                        .controlSize(.regular)
                        .progressViewStyle(.circular)
                case .error:
                    Text("💩")
                }
            } else {
                cacheStatusImage
            }
        }
    }

    private var previewImage: some View {
        VStack {
            if model.previewImageName != nil {
                Image(file: model.previewImageName)?
                    .resizable()
                    .background(Color.random)
                    .cornerRadius(5)
            } else {
                Rectangle()
                    .fill(.secondary)
                    .cornerRadius(5)
                    .background(
                        Image(systemName: "cube")
                            .resizable()
                            .padding()
                    )
            }
        }
        .frame(width: 50, height: 50)
    }
}

#Preview {
    VimModelRowView(model: ModelContainer.mocks.first!)
}
