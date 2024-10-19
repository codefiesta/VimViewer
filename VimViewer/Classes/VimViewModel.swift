//
//  VimViewModel.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import Observation
import VimKit

@Observable
final class VimViewModel {

    /// Shared application view model.
    static let shared: VimViewModel = .init()

    /// Holds the id of the currently selected instance id.
    var id: Int?
    /// Holds the current total hidden count.
    var hiddenCount: Int = 0

    /// Updates the view model from emitted  event data.
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
