//
//  GeometryStateView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct GeometryStateView: View {

    @ObservedObject
    var geometry: Geometry

    init?(geometry: Geometry?) {
        guard let geometry else { return nil }
        self.geometry = geometry
    }

    var body: some View {
        VStack {
            switch geometry.state {
            case .loading:
                ProgressView("Loading")
                    .controlSize(.small)
            case .indexing:
                ProgressView("Indexing")
                    .controlSize(.small)
            case .error(let error):
                Text(error)
            case .unknown, .ready:
                EmptyView()
            }
        }
    }
}
