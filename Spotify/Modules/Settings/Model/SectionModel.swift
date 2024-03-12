//
//  SectionModel.swift
//  Spotify
//
//  Created by rauan on 3/1/24.
//

import Foundation

struct SectionModel {
    let title: String
    let row: [Row]
}

struct Row {
    let title: String
    let handler: () -> Void
}
