//
//  POCListTableViewCell.swift
//  InfosysAssignment
//
//  Created by Balaji S on 22/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import UIKit
import SDWebImage

class POCListTableViewCell: UITableViewCell {

    var pocModel: POCListViewModel? {
        didSet {
            modelImageView.sd_setImage(with: pocModel?.imageURL)
            titleLabel.text = pocModel?.title
            descriptionLabel.text = pocModel?.description
        }
    }

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let modelImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 5
        imgView.clipsToBounds = true
        return imgView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(modelImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)

        self.selectionStyle = .none

        modelImageView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 10).isActive = true
        modelImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        modelImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        modelImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        modelImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: modelImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true

        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -10).isActive = true


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
