//
//  VimMainContentView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

// The main content view
struct VimMainContentView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    var body: some View {
        VimModelListView()
            .padding()
    }
}

#Preview {
    VimMainContentView()
}
