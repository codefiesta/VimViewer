//
//  VimHiddenElementsView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimHiddenInstancesView: View {
    
    @EnvironmentObject
    var vim: Vim
    
    @Environment(\.viewModel)
    var viewModel: VimViewModel
    
    var hiddenCount: Int {
        viewModel.hiddenCount
    }
    
    /// Determines if the hidden objects row is visible or not
    var isHiddenObjectsRowVisible: Bool {
        viewModel.hiddenCount > .zero
    }
    
    /// Determines if the hidden objects row is visible or not
    var isClipPlanesRowVisible: Bool {
        vim.camera.clipPlanes.allSatisfy { $0 != .invalid }
    }
    
    /// Determines if the entire view is visible or not
    var isVisible: Bool {
        isHiddenObjectsRowVisible || isClipPlanesRowVisible
    }

    var body: some View {
        ZStack {
            if isVisible {
                Grid(verticalSpacing: 8) {
                    if isHiddenObjectsRowVisible {
                        GridRow {
                            Image(systemName: "eye.slash")
                            Text("\(hiddenCount) Hidden Objects")
                            unhideAllButton
                        }
                    }
                    if isClipPlanesRowVisible {
                        GridRow {
                            Image(systemName: "square.on.square.dashed")
                            Text("Clip Planes Enabled")
                            removeClipPlanesButton
                        }
                    }
                }
                .fixedSize()
                .padding()
                .background(Color.black.opacity(0.65)).cornerRadius(8)
            }
        }
    }
    
    private var unhideAllButton: some View {
        Button {
            Task {
                await vim.unhide()
            }
        } label: {
            Image(systemName: "trash")
            //Text("Unhide")
        }
        .buttonStyle(.plain)
    }
    
    private var removeClipPlanesButton: some View {
        Button {
            vim.camera.clipPlanes.invalidate()
        } label: {
            Image(systemName: "trash")
            //Text("Clear")
        }
        .buttonStyle(.plain)
    }
}

#Preview {

    let vim: Vim = .init()
    let viewModel: VimViewModel = .init()
    viewModel.hiddenCount = 10

    return VimHiddenInstancesView()
        .environmentObject(vim)
        .environment(viewModel)
}
