//
//  POCViewModel.swift
//  InfosysAssignment
//
//  Created by Balaji S on 22/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit

struct POCViewModel {
    private let pocModel: POCModel

    lazy var headerTitle: String? = {
        return pocModel.title
    }()

    lazy var list: [POCListViewModel]? = {
        return pocModel.rows.map { (model) -> POCListViewModel in
            return POCListViewModel(title: model.title, description: model.description, imageURL: URL(string: model.imageHref))
        }
    }()

}

struct POCListViewModel {

    let title: String?
    let description: String?
    let imageURL: URL?

}
