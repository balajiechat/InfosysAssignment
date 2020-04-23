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

    var presenter: POCPresenterProtocol? { get set }

    func updateUI(with data: POCViewModel)

}

enum POCConstants: String {
    case POCTableViewCellIdentifier
}

class POCViewController: UIViewController {

	var presenter: POCPresenterProtocol?
    var pocViewModel: POCViewModel?

    private let activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator.style = .medium
        } else {
            indicator.style = .gray
        }
        indicator.hidesWhenStopped = true
        indicator.startAnimating()

        return indicator
    }()

    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        return refresh
    }()

    let tableView: UITableView = {
        let table = UITableView()
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table.estimatedRowHeight = 2.0
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
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.delegate = self
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        let cellID = POCConstants.POCTableViewCellIdentifier.rawValue
        tableView.register(POCListTableViewCell.self, forCellReuseIdentifier: cellID)

        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.center = self.view.center
    }

    @objc private func refreshData() {
        activityIndicatorView.startAnimating()
        self.presenter?.getData()
    }
}

extension POCViewController: POCViewProtocol {

    func updateUI(with data: POCViewModel) {
        pocViewModel = data
        DispatchQueue.main.async {
            self.title = self.pocViewModel?.headerTitle
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.refreshControl.endRefreshing()
            self.activityIndicatorView.stopAnimating()
        }
    }

}

extension POCViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return pocViewModel?.list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = POCConstants.POCTableViewCellIdentifier.rawValue
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? POCListTableViewCell
        cell?.pocModel = pocViewModel?.list?[indexPath.row]

        return cell ?? UITableViewCell()
    }

}
