//
//  VimModelDetail.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimModelDetail: View {

    @EnvironmentObject
    var vim: Vim
    var model: VimModel

    var body: some View {

        VStack {
            Text(model.name)
                .bold()

            Text("\(vim.state)")
                .bold()
            Spacer()
            Text(model.url.absoluteString)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .navigationTitle(model.name)
    }
}

#Preview {
    let model = VimModelContainer.mocks.first!
    let vim: Vim = .init()
    VimModelDetail(model: model).environmentObject(vim)
}
