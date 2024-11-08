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
        .sheet(isPresented: .constant(viewModel.isPresenting), onDismiss: onSheetDismiss) {
            NavigationStack {
                sheetView
                    .toolbar {
                        sheetToolbar
                    }
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
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
                    VimInstanceSummaryView()
                    Spacer()
                }
            }
        }
        .padding()
    }

    /// Builds the sheet view based on the current presentable.
    private var sheetView: some View {
        ZStack {
            switch viewModel.presentable {
            case .none:
                EmptyView()
            case .inspector:
                VimInstanceInspectorView()
            }
        }
    }

    /// Builds the sheet toolbar items.
    private var sheetToolbar: some View {
        Button {
            viewModel.presentable = .none
        } label: {
            Image(systemName: "xmark")
        }
    }

    /// Handles any sheet dismiss cleanup items.
    private func onSheetDismiss() {
        // Toggle the instance selection
        if let id = viewModel.self.id {
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
