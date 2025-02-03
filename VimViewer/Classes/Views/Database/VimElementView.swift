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

    var body: some View {

        VStack(alignment: .leading) {
            HStack {
                Text("Workset").bold()
                Text(element.workset?.name ?? .empty)
            }
            HStack {
                Text("Category").bold()
                Text(element.category?.name ?? .empty)
            }
            HStack {
                Text("Family Name").bold()
                Text(element.familyName ?? .empty)
            }
            HStack {
                Text("Family Type").bold()
                Text(element.familyName ?? .empty)
            }
            HStack {
                Text("Element ID").bold()
                Text(element.elementId.formatted(.plain))
            }
            HStack {
                Text("Unique ID").bold()
                Text(element.uniqueId ?? .empty)
            }
        }
        #if !os(macOS)
        .navigationTitle(Text("\(element.name ?? .empty) [\(element.elementId.formatted(.plain))]"))
        #endif
    }
}

#Preview {
    VimElementView(element: .init())
}
