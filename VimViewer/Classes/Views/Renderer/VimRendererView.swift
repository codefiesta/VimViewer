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
            HStack {
                VimToolbarView()
            }
        }
    }
}

#Preview {
    let vim: Vim = .init()
    VimRendererView().environmentObject(vim)
}
#endif
