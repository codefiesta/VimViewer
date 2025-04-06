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

extension Int: @retroactive Identifiable {
    public var id: Int {
        return self
    }
}

extension Int64: @retroactive Identifiable {
    public var id: Int64 {
        return self
    }
}

