//
//  VimElementView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimElementView: View {

    var element: Database.Element

    init?(element: Database.Element?) {
        guard let element else { return nil }
        self.element = element
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("\(element.name ?? .empty) [\(element.elementId.formatted(.plain))]")
            }
            .font(.headline)
            HStack(spacing: 2) {
                Text("Category:").bold()
                Text(element.category?.name ?? .empty)
            }
            HStack(spacing: 2) {
                Text("Family:").bold()
                Text(element.familyName ?? .empty)
            }
            HStack(spacing: 2) {
                Text("ID:").bold()
                Text(element.uniqueId ?? .empty)
            }
        }
        .font(.caption)
        #if !os(macOS)
        .navigationTitle(Text("\(element.name ?? .empty) [\(element.elementId.formatted(.plain))]"))
        #endif
    }
}

#Preview {
    VimElementView(element: .init())
}
