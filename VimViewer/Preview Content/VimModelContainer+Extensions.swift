//
//  VimModelContainer+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import Foundation
import SwiftData

extension VimModelContainer {

    /// Provides the default mock / sample files.
    static let mocks: [VimModel] = {
        [
            VimModel(name: "Residence",
                         url: URL(string: "https://vim02.azureedge.net/samples/residence.v1.2.75.vim")!),
            VimModel(name: "Dwelling",
                         url: URL(string: "https://vim02.azureedge.net/samples/dwelling.vim")!),
            VimModel(name: "Medical Tower",
                         url: URL(string: "https://vim02.azureedge.net/samples/skanska.vim")!),
            VimModel(name: "Substation",
                         url: URL(string: "https://vim02.azureedge.net/samples/substation.vim")!),
            VimModel(name: "Snowdon Towers",
                         url: URL(string: "https://vim02.azureedge.net/samples/snowden.vim")!),
            VimModel(name: "Stadium",
                         url: URL(string: "https://vim02.azureedge.net/samples/stadium.vim")!)
        ]
    }()
}
