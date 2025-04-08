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

    /// Provides enum constants for presenting focused sheet views.
    enum Focus: Sendable {
        /// Nothing being presented
        case none
        /// Viewpoints are being presented.
        case views
        /// Levels are being presented.
        case levels
        /// Rooms are being presented.
        case rooms
        /// The object tree is being presented.
        case tree
        /// Settings are being presented.
        case settings
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
    /// Holds the current total isolated instances count.
    var isolatedCount: Int = 0
    /// Boolean indicating if the renderer is active or not.
    var isRendering: Bool = false
    /// Boolean indicating if a focus sheet should be presented or not.
    var isSheetPresenting: Bool = false
    /// Boolean indicating if the assistant is enabled or not.
    var enableAssistant: Bool = false
    /// The current sheet focus (being displayed as a `.sheet{...}`).
    var sheetFocus: Focus = .none {
        didSet {
            isSheetPresenting.toggle()
        }
    }

    /// Updates the view model from emitted event data.
    /// - Parameter event: the event data to process.
    func update(_ event: Vim.Event) {
        switch event {
        case .empty:
            self.id = nil
            self.isSheetPresenting = false
        case .selected(let id, let selected, _, _):
            self.id = selected ? id : nil
        case .hidden(let count):
            self.id = nil
            self.hiddenCount = count
        case .isolated(let count):
            self.isolatedCount = count
        }
    }
}
