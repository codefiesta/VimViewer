//
//  VimInstanceInspectorView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

enum PropertySelectionScope: Int, Identifiable, CaseIterable {

    var id: Int { return rawValue }

    case instance, type

    var displayName: String {
        switch self {
        case .instance:
            return "Instance Properties"
        case .type:
            return "Type Properties"
        }
    }
}

struct VimInstanceInspectorView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Environment(\.modelContext)
    var modelContext

    /// The database element associated with the currently selected instance id.
    @State
    var element: Database.Element?

    @State
    var propertyScope: PropertySelectionScope = .instance

    var body: some View {

        ScrollViewReader { proxy in
            if let element {
                VimElementView(element: element)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                .padding()

                Picker("", selection: $propertyScope) {
                    ForEach(PropertySelectionScope.allCases, id: \.self) { scope in
                        Text(scope.displayName)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                VimElementParametersView(scope: propertyScope, element: element)
            }
        }

    }
}

#Preview {
    VimInstanceInspectorView()
}
