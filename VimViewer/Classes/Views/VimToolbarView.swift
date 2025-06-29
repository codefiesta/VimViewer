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

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Environment(\.modelContext)
    var modelContext

    var body: some View {

        VStack {

            //VimCameraDebugView(camera: vim.camera)
            Spacer()

            HStack(alignment: .bottom, spacing: 16) {
                homeButton
                viewsButton
                levelsButton
                roomsButton
                treeButton
                xRayButton
                assistantButton
                settingsButton
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 6)
            .background(Color.black.opacity(0.65)).cornerRadius(8)
        }
        .padding()
    }

    /// Sends the user to the home viewpoint.
    private func goHome() {
        var fetchDescriptor = FetchDescriptor<Database.View>(sortBy: [SortDescriptor(\Database.View.index)])
        fetchDescriptor.fetchLimit = 1
        guard let views = try? modelContext.fetch(fetchDescriptor), views.isNotEmpty else { return }
        let view = views[0]
        vim.camera.look(in: view.direction, from: view.position)
    }

    var homeButton: some View {
        Button(action: {
            goHome()
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
            viewModel.sheetFocus = .views
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
            viewModel.sheetFocus = .levels
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
            viewModel.sheetFocus = .rooms
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
            viewModel.sheetFocus = .tree
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

    var assistantButton: some View {
        Button(action: {
            viewModel.enableAssistant.toggle()
        }) {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "apple.intelligence")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(
                        .angularGradient(
                            colors: [.red, .yellow, .green, .blue, .purple, .red],
                            center: .center, startAngle: .zero, endAngle: .degrees(360)
                        )
                    )
                Text("Assistant").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var settingsButton: some View {
        Button(action: {
            viewModel.sheetFocus = .settings
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
