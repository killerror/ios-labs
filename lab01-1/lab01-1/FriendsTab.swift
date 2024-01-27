//
//  friendsTab.swift
//  lab01-1
//
//  Created by Ринат Мурзалиев on 21.01.2024.
//

import UIKit

final class FriendCellIterator: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatarImage)
        contentView.addSubview(captionText)
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
        caption.text = "friend name"
        caption.textColor = .black
        return caption
    }()
    
    private func setConstrs(){
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        captionText.translatesAutoresizingMaskIntoConstraints = false
        let avatarSide: CGFloat = 50
        NSLayoutConstraint.activate([
            avatarImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            avatarImage.widthAnchor.constraint(equalToConstant: avatarSide),
            avatarImage.heightAnchor.constraint(equalToConstant: avatarSide),
            
            captionText.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 10),
            captionText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
            
        ])
    }

}

final class FriendsTab: UITableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendReuseID") as? FriendCellIterator else {
            return UITableViewCell()
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Friends"
        tableView.register(FriendCellIterator.self, forCellReuseIdentifier: "friendReuseID")
        let ns = NetworkService()
        ns.getFriends()
    }
    
}
