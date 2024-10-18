//
//  VimDatabaseView.swift
//  VimViewer
//
//  Created by Kevin McKee
//

import SwiftUI
import VimKit

struct VimDatabaseView: View {

    @ObservedObject
    var db: Database

    init?(db: Database?) {
        guard let db else { return nil }
        self.db = db
    }


    var body: some View {
        Text("\(db.state)")
    }
}
