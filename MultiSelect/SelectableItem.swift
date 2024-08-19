//
//  SelectableItem.swift
//  MultiSelect
//
//  Created by Макс on 18.08.2024.
//

import SwiftUI

struct SelectableItem: Identifiable {
    let id: Int
    let title: String
    let required: Bool
    let tappedOnSelectAll: Bool
    var isSelected: Bool = false
}
