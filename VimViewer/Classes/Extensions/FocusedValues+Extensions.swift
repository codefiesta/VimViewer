//
//  FocusedValues+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI

struct FocusedModelKey: FocusedValueKey {
    typealias Value = VimDataModel
}

struct FocusedModelBinding: FocusedValueKey {
    typealias Value = Binding<VimDataModel>
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
