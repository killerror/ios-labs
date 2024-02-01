//
//  friendsTab.swift
//  lab01-1
//
//  Created by Ринат Мурзалиев on 21.01.2024.
//

import UIKit

final class GroupCellIterator: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImage)
        contentView.addSubview(captionText)
        contentView.addSubview(descText)
        setConstrs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var avatarImage: UIImageView = {
        let avatar = UIImageView()
        avatar.backgroundColor = .blue
        avatar.layer.cornerRadius = 25
        return avatar
    }()

    private var captionText: UILabel = {
        let caption = UILabel()
        caption.text = "Group name"
        caption.textColor = .black
        return caption
    }()

    private var descText: UILabel = {
        let caption = UILabel()
        caption.text = "Group description"
        caption.textColor = .black
        return caption
    }()

    func updateCell(group: Group) {
        
        captionText.text = group.name
        descText.text = group.desc

        DispatchQueue.global().async {
            
            // Проверяем урл картинки и следом получаем саму картинку по этому урл через try? Data
            if let url = URL(string: group.photo), let image = try? Data(contentsOf: url) {
                
                DispatchQueue.main.async {
                    self.avatarImage.image = UIImage(data: image)
                }
            }
        }
    }

    
    private func setConstrs(){
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        captionText.translatesAutoresizingMaskIntoConstraints = false
        descText.translatesAutoresizingMaskIntoConstraints = false
        let avatarSide: CGFloat = 50
        NSLayoutConstraint.activate([
            avatarImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            avatarImage.widthAnchor.constraint(equalToConstant: avatarSide),
            avatarImage.heightAnchor.constraint(equalToConstant: avatarSide),
            
            captionText.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 10),
            captionText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            descText.leftAnchor.constraint(equalTo: captionText.leftAnchor),
            descText.rightAnchor.constraint(equalTo: captionText.rightAnchor),
            descText.topAnchor.constraint(equalTo: captionText.bottomAnchor, constant: 5)

        ])
    }

}

final class GroupsTab: UITableViewController {
    private var groupModel: [Group] = []

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupReuseID") as? GroupCellIterator else {
            return UITableViewCell()
        }
        cell.updateCell(group: groupModel[indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Groups"
        tableView.register(GroupCellIterator.self, forCellReuseIdentifier: "groupReuseID")
        let ns = NetworkService()
        ns.getGroups { [weak self] groups in
            
            self?.groupModel = groups
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}

