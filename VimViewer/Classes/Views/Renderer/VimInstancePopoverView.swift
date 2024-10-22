//
//  VimInstancePopoverView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftData
import SwiftUI
import VimKit

struct VimInstancePopoverView: View {

    @EnvironmentObject
    var vim: Vim

    @Environment(\.viewModel)
    var viewModel: VimViewModel

    /// Uses the vim db model container main context.
    /// TODO: Need to investigate setting the from `.modelContainer(vim.db.modelContainer)`
    private var modelContext: ModelContext? {
        guard let db = vim.db, db.state == .ready else { return nil }
        return db.modelContainer.mainContext
    }

    var isVisible: Bool {
        viewModel.id != nil
    }

    /// The database element associated with the currently selected instance id.
    @State
    var element: Database.Element?

    var body: some View {
        ZStack {
            if isVisible {
                VStack {
                    Text("\(element?.name ?? .empty) [\(element?.elementId.formatted(.plain) ?? .empty)]")
                        .bold()
                        .padding()
                    HStack {
                        Text("Category").font(.caption2).bold()
                        Text(element?.category?.name ?? .empty).font(.caption2)
                    }.padding([.bottom], 4)

                    HStack {
                        Text("Family").font(.caption2).bold()
                        Text(element?.familyName ?? .empty).font(.caption2)
                    }
                    .padding([.bottom], 8)

                    HStack(alignment: .bottom, spacing: 16) {
                        hideButton
                        hideSimilarButton
                        inspectButton
                    }
                }
                .padding([.leading, .trailing, .bottom])
                .padding([.top], 4)
                .background(Color.black.opacity(0.65))
                .cornerRadius(8)
                .onAppear {
                    load()
                }
            }
        }
    }

    var hideButton: some View {
        Button {
            guard let id = viewModel.id else { return }
            Task {
                await vim.hide(ids: [id])
            }
        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "eye.slash")
                Text("Hide").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var hideSimilarButton: some View {
        Button {
            hideSimilar()
        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "eye.slash.fill")
                Text("Similar").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    var inspectButton: some View {
        Button {

        } label: {
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: "info.circle")
                Text("Inspect").font(.caption2)
            }
        }
        .buttonStyle(.plain)
    }

    /// Loads the selected instance element data from the database.
    private func load() {
        guard let modelContext, let id = viewModel.id else { return }
        let index = Int64(id)
        let predicate = #Predicate<Database.Node>{ $0.index == index }
        var fetchDescriptor = FetchDescriptor<Database.Node>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        guard let results = try? modelContext.fetch(fetchDescriptor), results.isNotEmpty else { return
        }
        element = results.first?.element
    }

    /// Hides similar instances to the currently selected instance.
    /// The logic is to hide all instances that are in the same family.
    private func hideSimilar() {
        guard let modelContext, let element,
              let familyName = element.familyName else { return }

        let predicate = #Predicate<Database.Node>{ $0.element?.familyName == familyName }
        let fetchDescriptor = FetchDescriptor<Database.Node>(predicate: predicate)
        guard let results = try? modelContext.fetch(fetchDescriptor), results.isNotEmpty else { return
        }
        let ids = results.compactMap{ Int($0.index) }
        Task {
            await vim.hide(ids: ids)
        }
    }

}

#Preview {
    let vim: Vim = .init()
    VimInstancePopoverView()
        .environmentObject(vim)
        .environment(VimViewModel())
}
