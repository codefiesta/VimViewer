//
//  VimViewModel.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import Observation
import SwiftData
import VimKit

@Observable
final class VimViewModel {

    /// Shared application view model.
    static let shared: VimViewModel = .init()

    /// Provides enum constants for view model presentables.
    enum Presentable: Sendable {
        case none
        case inspector
    }

    /// The model container.
    let modelContainer: ModelContainer = .default
    /// The model descriptor.
    var descriptor: VimModelDescriptor?
    /// Convenience var for the model name.
    var name: String { descriptor?.name ?? .empty }
    /// Holds the id of the currently selected instance id.
    var id: Int?
    /// Holds the current total hidden instances count.
    var hiddenCount: Int = 0
    /// Boolean indicating if a presentable should be presented or not.
    var isPresenting: Bool = false
    /// The current presentable (most likely being displayed as a `.sheet{...}`).
    var presentable: Presentable = .none {
        didSet {
            isPresenting.toggle()
        }
    }

    /// Updates the view model from emitted event data.
    /// - Parameter event: the event data to process.
    func update(_ event: Vim.Event) {
        switch event {
        case .empty:
            self.id = nil
        case .selected(let id, let selected, _, _):
            self.id = selected ? id : nil
        case .hidden(let hiddenCount):
            self.id = nil
            self.hiddenCount = hiddenCount
        }
    }
}
