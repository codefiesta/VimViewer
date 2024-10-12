//
//  VimModelRow.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

struct VimModelRow: View {

    var model: VimModel

    var body: some View {
        HStack {
            Image(systemName: "cube")
                .resizable()
                .frame(width: 20, height: 20)
                .cornerRadius(5)
            VStack(alignment: .leading) {
                Text(model.name)
                    .bold()
            }
        }
        .padding()
    }
}

#Preview {
    VimModelRow(model: VimModelContainer.mocks.first!)
}
