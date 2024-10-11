//
//  VimContentView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

// The main content view
struct VimContentView: View {

    var body: some View {
        VimListView()
            .padding()

    }
}

#Preview {
    VimContentView()
}
