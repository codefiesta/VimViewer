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
                         url: URL(string: "https://www.dropbox.com/scl/fi/fgfdtc2r42wy8p3tpd5da/dwelling.vim?rlkey=osryntcuqvnj5qypyh4hb96xp&st=3m8xdu9t&dl=1")!),
            VimModel(name: "Medical Tower",
                         url: URL(string: "https://vim02.azureedge.net/samples/skanska.vim")!),
            VimModel(name: "Substation",
                         url: URL(string: "https://www.dropbox.com/scl/fi/whi5faawkxjr9xiq148si/substation.vim?rlkey=xdfhuvq6xvd3sd9ffr3ouu1uj&st=gm7q1ite&dl=1")!),
            VimModel(name: "Snowdon Towers",
                         url: URL(string: "https://www.dropbox.com/scl/fi/cf4t5o0cjyxdn7ofpngsy/snowden.vim?rlkey=n368sb983zvpebz1pr9iic3ax&st=euigrt62&dl=1")!),
            VimModel(name: "Stadium",
                         url: URL(string: "https://vim02.azureedge.net/samples/stadium.vim")!)
        ]
    }()
}
