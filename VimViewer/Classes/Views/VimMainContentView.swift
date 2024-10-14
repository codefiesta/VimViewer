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

    var body: some View {
        VimModelListView()
            .padding()
    }
}

#Preview {
    VimMainContentView()
}
