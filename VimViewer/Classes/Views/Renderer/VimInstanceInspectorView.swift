////
////  VimInstanceInspectorView.swift
////  VimViewer
////
////  Created by Kevin McKee
////
//
//import SwiftData
//import SwiftUI
//import VimKit
//
//struct VimInstanceInspectorView: View {
//
//    @EnvironmentObject
//    var vim: Vim
//
//    @Environment(\.modelContext)
//    var modelContext
//
//    /// The database element associated with the currently selected instance id.
//    @State
//    var element: Database.Element?
//
//    @State
//    var propertyScope: PropertySelectionScope = .instance
//
//    /// The instance id.
//    var id: Int
//
//    /// Common Initializer
//    /// - Parameter id: the instance id
//    init?(id: Int?) {
//        guard let id else { return nil }
//        self.id = id
//    }
//
//    var body: some View {
//
//        ScrollViewReader { proxy in
//            if let element {
//                VimElementView(element: element)
//                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
//                    .padding()
//
//                Picker(.empty, selection: $propertyScope) {
//                    ForEach(PropertySelectionScope.allCases, id: \.self) { scope in
//                        Text(scope.displayName)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//
//                VimElementParametersView(scope: propertyScope, element: element)
//            }
//        }
//        .onAppear {
//            load()
//        }
//    }
//
//    /// Loads the selected instance element data from the database.
//    private func load() {
//        let index = Int64(id)
//        let predicate = #Predicate<Database.Node>{ $0.index == index }
//        var fetchDescriptor = FetchDescriptor<Database.Node>(predicate: predicate)
//        fetchDescriptor.fetchLimit = 1
//        guard let results = try? modelContext.fetch(fetchDescriptor), results.isNotEmpty else { return
//        }
//        element = results.first?.element
//    }
//}
//
//#Preview {
//    VimInstanceInspectorView(id: 0)
//}
