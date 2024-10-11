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
    static let mocks: [VimDataModel] = {
        [
            VimDataModel(name: "Residence",
                         url: URL(string: "https://vim02.azureedge.net/samples/residence.v1.2.75.vim")!),
            VimDataModel(name: "Dwelling",
                         url: URL(string: "https://drive.usercontent.google.com/download?id=1pK6ekjRcLXwx41_kx8ct-TXt2oiIk64J&export=download&authuser=0&confirm=t&uuid=0a8e5cf8-edf5-4244-8673-74be5faca923&at=APZUnTXuhhajzYdg_pvKS63BUe_r:1706902849320")!),
            VimDataModel(name: "Medical Tower",
                         url: URL(string: "https://vim02.azureedge.net/samples/skanska.vim")!),
            VimDataModel(name: "Substation",
                         url: URL(string: "https://drive.usercontent.google.com/download?id=1rFt0L5aoqWDJss0PBPDoIHjGwmTLQBwG&export=download&authuser=0&confirm=t&uuid=0f967fed-a8fb-49c2-81ea-18ead5eca7ec&at=APZUnTVvSuTP1MDzbzfZS1InzR_O:1724008938685")!),
            VimDataModel(name: "Snowdon Towers",
                         url: URL(string: "https://vimcloudcdnprod.azureedge.net/383d1ca3-9d64-4a0f-e993-08daab96eebf/592827ab-9a5a-4ad7-8588-9ed9fbc0ab74?sv=2023-11-03&se=2024-09-26T00%3A44%3A28Z&sr=b&sp=r&rscd=attachment%3B+filename%3DSample+Snowdon+Towers.vim&sig=cQM6V4wiY1slUuksN8goh7qVcWlAyO6tQx0neA%2FnitU%3D")!),
            VimDataModel(name: "Stadium",
                         url: URL(string: "https://vim02.azureedge.net/samples/stadium.vim")!)
        ]
    }()
}
