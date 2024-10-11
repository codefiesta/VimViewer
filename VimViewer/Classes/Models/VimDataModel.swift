//
//  VimDataModel.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import Foundation
import SwiftData

@Model
class VimDataModel {

    var name: String
    @Attribute(.unique)
    var url: URL

    public init(name: String, url: URL) {
        self.name = name
        self.url = url
    }

}
