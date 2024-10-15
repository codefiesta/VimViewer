//
//  VimModel.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import Foundation
import SwiftData

/// A type that holds model meta data.
@Model
class VimModel {

    /// Index the model fields.
    #Index<VimModel>([\.name])

    /// The model name.
    var name: String

    /// The model source url.
    @Attribute(.unique)
    var url: URL

    /// The model preview image name.
    /// Once the model has been downloaded, we extract this from the assets buffer and save it to disk.
    var previewImageName: String?

    /// Initializer
    /// - Parameters:
    ///   - name: the model name
    ///   - url: the remote source (remote) url.
    public init(name: String, url: URL) {
        self.name = name
        self.url = url
    }

}
