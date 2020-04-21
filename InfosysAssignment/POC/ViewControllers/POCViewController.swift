//
//  POCViewController.swift
//  InfosysAssignment
//
//  Created Balaji S on 21/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//
//

import UIKit

protocol POCViewProtocol: class {

    var presenter: POCPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}

class POCViewController: UIViewController, POCViewProtocol {

	var presenter: POCPresenterProtocol?
    let tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
	override func viewDidLoad() {
        super.viewDidLoad()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)

        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
