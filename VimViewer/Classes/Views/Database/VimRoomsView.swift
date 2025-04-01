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

    @Query(sort: \Database.Room.number)
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

                HStack(alignment: .top) {
                    // 1st column
                    Text(room.number)
                        .font(.title2)

                    // 2nd column
                    VStack(alignment: .leading) {
                        Text(room.element?.name ?? .empty)
                            .font(.title2)
                        HStack {
                            Text("Area")
                            Text(room.area.formatted(.default))
                        }.font(.caption)

                        HStack {
                            Text("Perimeter")
                            Text(room.perimeter.formatted(.default))
                        }.font(.caption2)
                    }

                    Spacer()

                    Button(action: {
                        onRoomButtonTap(room: room)
                    }, label: {
                        VStack(alignment: .center, spacing: 8) {
                            Image(systemName: "square.arrowtriangle.4.outward")
                            Text("Section").font(.caption2)
                        }
                    })
                    .buttonStyle(.plain)
                }

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
