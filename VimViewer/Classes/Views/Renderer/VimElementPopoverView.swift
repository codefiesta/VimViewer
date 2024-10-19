//
//  VimElementPopoverView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimElementPopoverView: View {

    @EnvironmentObject
    var vim: Vim

    var id: Int?

    var element: Database.Element? {
        nil
    }

    init?(id: Int? = nil) {
        guard id != nil else { return nil }
        self.id = id
    }

    var body: some View {
        VStack {
            Text("\(element?.name ?? .empty) [\(element?.elementId.formatted(.plain) ?? .empty)]")
                .bold()
                .padding()
            HStack {
                Text("Category").font(.caption2).bold()
                Text(element?.category?.name ?? .empty).font(.caption2)
            }.padding([.bottom], 4)

            HStack {
                Text("Family").font(.caption2).bold()
                Text(element?.familyName ?? .empty).font(.caption2)
            }
            .padding([.bottom], 8)

            HStack(alignment: .bottom, spacing: 16) {
                hideButton
                hideSimilarButton
                inspectButton
            }
        }
        .padding([.leading, .trailing, .bottom])
        .padding([.top], 4)
        .background(Color.black.opacity(0.65)).cornerRadius(8)

    }

    var hideButton: some View {
        Button {

        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "eye.slash")
                Text("Hide").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var hideSimilarButton: some View {
        Button {
        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "eye.slash.fill")
                Text("Similar").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var inspectButton: some View {
        Button {

        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "info.circle")
                Text("Inspect").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

}

#Preview {
    let vim: Vim = .init()
    VimElementPopoverView().environmentObject(vim)
}
