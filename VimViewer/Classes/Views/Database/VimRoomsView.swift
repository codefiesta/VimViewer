//
//  VimRoomsView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimRoomsView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    @Environment(\.modelContext)
    var modelContext

    @Query(sort: \Database.Room.element?.name)
    var allRooms: [Database.Room]

    /// The in-memory filtered results
    var rooms: [Database.Room] {
        guard searchText.isNotEmpty else { return allRooms }
        return allRooms.filter{ $0.element?.name?.lowercased().contains(searchText.lowercased()) ?? true}
    }

    @State
    var searchText: String = .empty

    var body: some View {
        List {
            ForEach(rooms) { room in
                Button(action: {
                    onRoomButtonTap(room: room)
                }, label: {
                    VStack(alignment: .leading) {
                        Text(room.element?.name ?? .empty)
                        HStack {
                            Text("Area").bold()
                            Text(room.area.formatted())
                        }
                        HStack {
                            Text("Perimeter").bold()
                            Text(room.perimeter.formatted())
                        }
                    }
                })
            }
        }
        .navigationTitle("Rooms")
        #if !os(macOS)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        #endif
    }

    /// Handles a room tap event.
    /// - Parameter room: the room that was selected
    private func onRoomButtonTap(room: Database.Room) {
        guard let geometry = vim.geometry, let element = room.element else { return }
        let index = element.index
        let predicate = #Predicate<Database.Node>{ $0.element?.index == index }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        guard let node = try? modelContext.fetch(fetchDescriptor).first else { return }
        
        let id = Int(node.index)
        guard let instance = geometry.instance(id: id) else { return }
        let clipPlanes = instance.boundingBox.planes
        vim.camera.clipPlanes = clipPlanes
        viewModel.sheetFocus = .none
    }
}

#Preview {
    VimRoomsView()
}
