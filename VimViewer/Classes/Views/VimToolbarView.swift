//
//  VimToolbarView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimToolbarView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.modelContext)
    var modelContext

    var body: some View {

        VStack {

            Spacer()

            HStack(alignment: .bottom, spacing: 16) {
                homeButton
                viewsButton
                levelsButton
                roomsButton
                treeButton
                xRayButton
                settingsButton
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 6)
            .background(Color.black.opacity(0.65)).cornerRadius(8)
        }
        .padding()
    }

    var homeButton: some View {
        Button(action: {

        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "house").foregroundColor(.white)
                Text("Home").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var viewsButton: some View {
        Button(action: {

        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "location.viewfinder")
                Text("Views").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var levelsButton: some View {
        Button(action: {

        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "square.2.layers.3d")
                Text("Levels").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var roomsButton: some View {
        Button(action: {
        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "square.split.bottomrightquarter")
                Text("Rooms").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var treeButton: some View {
        Button(action: {

        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "square.3.layers.3d.down.right")
                Text("Objects").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var measureButton: some View {
        Button(action: {
        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "ruler").rotationEffect(Angle(degrees: -45))
                Text("Measure").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var xRayButton: some View {
        Button(action: {
            vim.options.xRay.toggle()
        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "cube.transparent").rotationEffect(Angle(degrees: -45))
                Text("X-Ray").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var settingsButton: some View {
        Button(action: {

        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "slider.horizontal.3").foregroundColor(.white)
                Text("Settings").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    let vim: Vim = .init()
    VimToolbarView().environmentObject(vim)
}
