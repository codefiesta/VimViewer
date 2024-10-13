//
//  VimAssetsView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimAssetsView: View {

    @EnvironmentObject
    var vim: Vim

    var names: [String] {
        vim.assets?.names.reversed() ?? .init()
    }

    var body: some View {
        ScrollViewReader { proxy in
            List(names) { name in
                vim.assets?.image(from: name)?
                    .resizable()
            }
        }
        .padding()
    }
}
