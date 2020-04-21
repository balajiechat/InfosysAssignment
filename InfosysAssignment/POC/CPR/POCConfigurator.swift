//
//  POCConfigurator.swift
//  InfosysAssignment
//
//  Created Balaji S on 21/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

class POCConfigurator: NSObject {

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = POCViewController()
        let interactor = POCInteractor()
        let router = POCRouter()
        let presenter = POCPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
