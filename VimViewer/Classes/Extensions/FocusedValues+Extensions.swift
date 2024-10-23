//
//  FocusedValues+Extensions.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct FocusedModelKey: FocusedValueKey {
    typealias Value = VimModelDescriptor
}

struct FocusedModelBindingKey: FocusedValueKey {
    typealias Value = Binding<VimModelDescriptor>
}

struct FocusedVimKey: FocusedValueKey {
    typealias Value = Vim
}

struct FocusedVimBindingKey: FocusedValueKey {
    typealias Value = Binding<Vim>
}

extension FocusedValues {

    var focusedModel: FocusedModelKey.Value? {
        get { self[FocusedModelKey.self] }
        set { self[FocusedModelKey.self] = newValue }
    }

    var focusedModelBinding: FocusedModelBindingKey.Value? {
        get { self[FocusedModelBindingKey.self] }
        set { self[FocusedModelBindingKey.self] = newValue }
    }

    var focusedVim: FocusedVimKey.Value? {
        get { self[FocusedVimKey.self] }
        set { self[FocusedVimKey.self] = newValue }
    }

    var focusedVimBinding: FocusedVimBindingKey.Value? {
        get { self[FocusedVimBindingKey.self] }
        set { self[FocusedVimBindingKey.self] = newValue }
    }
}
