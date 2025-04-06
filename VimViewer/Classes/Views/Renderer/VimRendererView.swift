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
            RendererContainerView(vim: vim)
            // Geometry loading state
            GeometryStateView(geometry: vim.geometry)
            // Info Views
            infoViews
        }
        .onReceive(vim.events) { event in
            handleEvent(event)
        }
        .sheet(isPresented: .constant(viewModel.isSheetPresenting), onDismiss: onSheetDismiss) {
            NavigationStack {
                sheetView
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
            .toolbar {
                sheetToolbar
            }
        }
        .modelContainer(optional: vim.db?.modelContainer)
    }

    /// Provides a 3 column layout view of quick actions and summary information.
    private var infoViews: some View {
        ZStack {
            HStack {

                // Column 1
                HStack {
                    VStack {
                        VimCoachMarkView()
                        Spacer()
                        VimStatsView()
                    }
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)

                // Column 2
                VStack {

                    // AI assistant (placeholder)

                    Spacer()

                    // Toolbar
                    VimToolbarView()
                }
                .frame(minWidth: 480, maxWidth: .infinity)

                // Column 3
                HStack {

                    Spacer()

                    VStack {
                        VimInstanceInspectorView(id: viewModel.id)
                        Spacer()
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
        .padding()
    }

    /// Builds the sheet view based on the current inspectable.
    private var sheetView: some View {
        ZStack {
            switch viewModel.sheetFocus {
            case .none:
                EmptyView()
            case .views:
                VimViewsView()
            case .levels:
                VimLevelsView()
            case .rooms:
                VimRoomsView()
            case .tree:
                VimTreeView()
            case .settings:
                VimSettingsView()
            }
        }
        #if os(macOS)
        .frame(minHeight: 400)
        #endif
    }

    /// Builds the sheet toolbar items.
    private var sheetToolbar: some View {
        Button {
            viewModel.sheetFocus = .none
        } label: {
            Image(systemName: "xmark")
        }
    }

    /// Handles any dismiss cleanup items.
    private func onSheetDismiss() {
        // Toggle the instance selection
        if let id = viewModel.id {
            vim.select(id: id)
        }
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
