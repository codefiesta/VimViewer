//
//  Identifiable+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import Foundation

extension String: @retroactive Identifiable {
    public var id: String {
        return self
    }
}
