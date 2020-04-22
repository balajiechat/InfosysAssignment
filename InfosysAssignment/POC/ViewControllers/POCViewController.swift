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

    func updateUI(with data: POCViewModel)

}

enum POCConstants: String {
    case POCTableViewCellIdentifier
}

class POCViewController: UIViewController {

	var presenter: POCPresenterProtocol?
    var pocViewModel: POCViewModel?

    let tableView : UITableView = {
        let table = UITableView()
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.estimatedRowHeight = 10
        table.rowHeight = UITableView.automaticDimension
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.presenter?.getData()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.register(POCListTableViewCell.self, forCellReuseIdentifier: POCConstants.POCTableViewCellIdentifier.rawValue)
    }

}

extension POCViewController: POCViewProtocol {

    func updateUI(with data: POCViewModel) {
        pocViewModel = data
        DispatchQueue.main.async {
            self.title = self.pocViewModel?.headerTitle
            self.tableView.reloadData()
        }
    }

}

extension POCViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return pocViewModel?.list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: POCConstants.POCTableViewCellIdentifier.rawValue, for: indexPath) as! POCListTableViewCell
        cell.pocModel = pocViewModel?.list?[indexPath.row]

        return cell
    }

}

