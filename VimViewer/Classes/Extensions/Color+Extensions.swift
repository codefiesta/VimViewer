//
//  Color+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

public extension Color {

    static var random: Color {
        .random(randomOpacity: true)
    }

    private static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
