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
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    VimContentView()
}
