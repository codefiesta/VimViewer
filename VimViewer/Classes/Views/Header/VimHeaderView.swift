//
//  VimHeaderView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimHeaderView: View {

    @EnvironmentObject
    var vim: Vim

    var keys: [String] {
        Array(vim.header.keys).sorted { $0 < $1 }
    }

    var body: some View {
        List(keys) { key in
            HStack {
                Text(key)
                Text(vim.header[key]!)
            }
        }
        .padding()
    }
}
