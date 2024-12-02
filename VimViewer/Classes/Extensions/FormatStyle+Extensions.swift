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

extension FormatStyle where Self == FloatingPointFormatStyle<Double> {

    /// Returns a default fractional style.
    public static var `default`: FloatingPointFormatStyle<Double> {
        let formatter: FloatingPointFormatStyle<Double> = .number
        return formatter.precision(.integerAndFractionLength(integerLimits: 1..<4, fractionLimits: 1..<2))
    }
}



