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

    /* Interactor -> Presenter */
}

protocol POCInteractorInputProtocol: class {

    var presenter: POCInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

class POCInteractor: POCInteractorInputProtocol {

    weak var presenter: POCInteractorOutputProtocol?
}
