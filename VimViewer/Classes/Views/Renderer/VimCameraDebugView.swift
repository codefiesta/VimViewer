//
//  VimCameraDebugView.swift
//  VimViewer
//
//  Created by Kevin McKee on 12/2/24.
//

import SwiftUI
import VimKit

struct VimCameraDebugView: View {

    @ObservedObject
    var camera: Vim.Camera

    var body: some View {
        HStack {
            Text("x: \(camera.position.x.formatted(.default)),")
            Text("y: \(camera.position.y.formatted(.default)),")
            Text("z: \(camera.position.z.formatted(.default))")
        }
        .fixedSize()
        .padding()
        .background(Color.black.opacity(0.65)).cornerRadius(8)
    }
}

#Preview {
    VimCameraDebugView(camera: .init())
}
