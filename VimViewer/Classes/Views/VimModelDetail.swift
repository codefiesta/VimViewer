//
//  VimModelDetail.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

struct VimModelDetail: View {

    var model: VimModel

    var body: some View {
        Text(model.name)
            .navigationTitle(model.name)
    }
}

#Preview {
    VimModelDetail(model: VimModelContainer.mocks.first!)
}
