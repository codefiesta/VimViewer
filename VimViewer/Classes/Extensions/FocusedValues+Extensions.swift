//
//  FocusedValues+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

struct FocusedModelKey: FocusedValueKey {
    typealias Value = VimModel
}

struct FocusedModelBinding: FocusedValueKey {
    typealias Value = Binding<VimModel>
}

extension FocusedValues {

    var focusedModel: FocusedModelKey.Value? {
        get { self[FocusedModelKey.self] }
        set { self[FocusedModelKey.self] = newValue }
    }

    var focusedModelBinding: FocusedModelBinding.Value? {
        get { self[FocusedModelBinding.self] }
        set { self[FocusedModelBinding.self] = newValue }
    }
}
