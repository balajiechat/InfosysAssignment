//
//  POCRouter.swift
//  InfosysAssignment
//
//  Created Balaji S on 21/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol POCRouterProtocol: class {

    func showAlert(title: String, message: String)

}

class POCRouter: POCRouterProtocol {

    weak var viewController: UIViewController?

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let exitAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(exitAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }

}
