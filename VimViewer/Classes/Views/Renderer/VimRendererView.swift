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
                    VimHiddenElementsView()
                    Spacer()
                }
                // Column 2
                Spacer()
                // Column 3
                VStack {
                    VimElementPopoverView()
                    Spacer()
                }
            }
        }
        .padding()
    }

    /// Handles vim events.
    /// - Parameter event: the event to handle
    private func handleEvent(_ event: Vim.Event) {
        switch event {
        case .empty:
            break
        case .selected(let id, let selected, let count, let position):
            break
        case .hidden(let count):
            break
        }
    }
}

#Preview {
    let vim: Vim = .init()
    VimRendererView().environmentObject(vim)
}
#endif
