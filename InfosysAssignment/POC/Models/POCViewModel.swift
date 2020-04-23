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
        let models = pocModel.rows?.map { (model) -> POCListViewModel in
            return POCListViewModel(title: model.title, description: model.description, urlString: model.imageHref)
        }
        return models?.filter { $0.title?.isEmpty == false }
    }()

    init(model: POCModel) {
        pocModel = model
    }

}

struct POCListViewModel {

    let title: String?
    let description: String?
    let imageURL: URL?

    init(title: String?, description: String?, urlString: String?) {
        self.title = title?.trimmingCharacters(in: .whitespaces)
        self.description = description?.trimmingCharacters(in: .whitespaces)
        self.imageURL = URL(string: urlString ?? "")
    }
}
