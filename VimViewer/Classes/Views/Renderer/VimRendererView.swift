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
            // Toolbar
            VimToolbarView()
            // Info Views
            infoViews
        }
        .onReceive(vim.events) { event in
            handleEvent(event)
        }
        #if os(iOS)
        .sheet(isPresented: .constant(viewModel.isInspecting), onDismiss: onSheetDismiss) {
            NavigationStack {
                inspectorView
                    .toolbar {
                        sheetToolbar
                    }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
        #elseif os(macOS)
        .inspector(isPresented: .constant(viewModel.isInspecting)) {
            NavigationStack {
                inspectorView
            }
        }
        #endif
        .modelContainer(optional: vim.db?.modelContainer)
    }

    /// Provides a 3 column layout view of quick actions and summary information.
    private var infoViews: some View {
        ZStack {
            HStack {

                // Column 1
                VStack {
                    VimHiddenInstancesView()
                    Spacer()
                    VimStatsView()
                }

                // Column 2
                Spacer()

                // Column 3
                VStack {
                    VimInstanceSummaryView(id: viewModel.id)
                    Spacer()
                }
            }
        }
        .padding()
    }

    /// Builds the inspector view based on the current inspectable.
    private var inspectorView: some View {
        ZStack {
            switch viewModel.inspector {
            case .none:
                EmptyView()
            case .instance:
                VimInstanceInspectorView(id: viewModel.id)
            }
        }
    }

    /// Builds the sheet toolbar items.
    private var sheetToolbar: some View {
        Button {
            viewModel.inspector = .none
        } label: {
            Image(systemName: "xmark")
        }
    }

    /// Handles any dismiss cleanup items.
    private func onInspectorDismiss() {
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
