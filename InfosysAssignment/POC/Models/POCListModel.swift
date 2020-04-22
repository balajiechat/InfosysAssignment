//
//  POCListModel.swift
//  InfosysAssignment
//
//  Created Balaji S on 21/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

struct POCModel: Codable {
    let title: String
    let rows: [POCListModel]
}

struct POCListModel: Codable {
    let title: String
    let description: String
    let imageHref: String
}
