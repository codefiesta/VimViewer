//
//  VimContentView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

// The main content view
struct VimContent: View {

    var body: some View {
        VimModelList()
            .padding()

    }
}

#Preview {
    VimContent()
}
