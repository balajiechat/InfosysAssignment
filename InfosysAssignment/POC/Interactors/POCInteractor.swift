//
//  POCInteractor.swift
//  InfosysAssignment
//
//  Created Balaji S on 21/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol POCInteractorOutputProtocol: class {

    func sendData(model: POCViewModel)

}

protocol POCInteractorInputProtocol: class {

    var presenter: POCInteractorOutputProtocol?  { get set }

    func getData()

}

class POCInteractor: POCInteractorInputProtocol {

    weak var presenter: POCInteractorOutputProtocol?

    func getData() {
        guard let url = URL(string: URLList.baseURL.rawValue) else {
            return
        }
        let resource = Resource<POCModel>(url: url)
        POCDataManager.fetchDataFromServer(resource: resource) { (result) in

            switch result {
            case .success(let list):
                self.presenter?.sendData(model: POCViewModel(model: list))

            case .failure(let error):
                print(error)
            }
        }
    }

}
