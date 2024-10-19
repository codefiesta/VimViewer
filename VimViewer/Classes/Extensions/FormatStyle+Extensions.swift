//
//  FormatStyle+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

extension FormatStyle where Self == IntegerFormatStyle<Int64> {

    /// Returns a plain style number formatter without grouping.
    public static var plain: IntegerFormatStyle<Int64> {
        let formatter: IntegerFormatStyle<Int64> = .number
        return formatter.grouping(.never)
    }
}

extension FormatStyle where Self == FloatingPointFormatStyle<Float> {

    /// Returns a plain style number formatter without grouping.
    public static var plain: FloatingPointFormatStyle<Float> {
        let formatter: FloatingPointFormatStyle<Float> = .number
        return formatter.grouping(.never)
    }
}



