//
//  VimRendererView.swift
//  VimViewer
//
//  Created by Kevin McKee
//
import SwiftUI
import VimKit

#if !os(visionOS)
struct VimRendererView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    var body: some View {
        ZStack {
            // The renderer
            VimRendererContainerView(vim: vim)
            // Geometry loading state
            GeometryStateView(geometry: vim.geometry)
            // Toolbar
            VimToolbarView()
            // Layover (Popovers)
            layoverViews
        }.onReceive(vim.events) { event in
            handleEvent(event)
        }
    }

    /// Provides a 3 column layover view.
    private var layoverViews: some View {
        ZStack {
            HStack {

                // Column 1
                VStack {
                    VimHiddenInstancesView()
                    Spacer()
                }

                // Column 2
                Spacer()

                // Column 3
                VStack {
                    VimInstancePopoverView()
                    Spacer()
                }
            }
        }
        .padding()
    }

    /// Handles vim events by updating the view model.
    /// - Parameter event: the event to handle
    private func handleEvent(_ event: Vim.Event) {
        viewModel.update(event)
    }
}

#Preview {
    let vim: Vim = .init()
    VimRendererView()
        .environmentObject(vim)
        .environment(VimViewModel())
}
#endif
