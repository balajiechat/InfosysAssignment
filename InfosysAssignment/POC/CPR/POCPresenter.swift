//
//  POCPresenter.swift
//  InfosysAssignment
//
//  Created Balaji S on 21/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol POCPresenterProtocol: class {

    var interactor: POCInteractorInputProtocol? { get set }

    func getData()
    func performSelectedAction(name: String)

}

class POCPresenter: POCPresenterProtocol {

    weak private var view: POCViewProtocol?
    var interactor: POCInteractorInputProtocol?
    private let router: POCRouterProtocol

    init(interface: POCViewProtocol, interactor: POCInteractorInputProtocol?, router: POCRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getData() {
        self.interactor?.getData()
    }

    func performSelectedAction(name: String) {
        self.router.showAlert(title: "Selected Action", message: name)
    }

}

extension POCPresenter: POCInteractorOutputProtocol {

    func sendData(model: POCViewModel) {
        self.view?.updateUI(with: model)
    }

}
