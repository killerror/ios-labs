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
        contentView.addSubview(friendIsOnline)
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

    private var friendIsOnline: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 5 // Половина длины стороны
        return view
    }()
    
    func updateCell(friend: Friend) {
        
        captionText.text = friend.firstName + " " + friend.lastName
        
        friendIsOnline.backgroundColor = friend.online == 1 ? .green : .red
        
        DispatchQueue.global().async {
            
            // Проверяем урл картинки и следом получаем саму картинку по этому урл через try? Data
            if let url = URL(string: friend.photo), let image = try? Data(contentsOf: url) {
                
                DispatchQueue.main.async {
                    self.avatarImage.image = UIImage(data: image)
                }
            }
        }
    }
    
    private func setConstrs(){
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        captionText.translatesAutoresizingMaskIntoConstraints = false
        friendIsOnline.translatesAutoresizingMaskIntoConstraints = false
        let avatarSide: CGFloat = 50
        NSLayoutConstraint.activate([
            avatarImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            avatarImage.widthAnchor.constraint(equalToConstant: avatarSide),
            avatarImage.heightAnchor.constraint(equalToConstant: avatarSide),
            
            captionText.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 10),
            captionText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            friendIsOnline.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            friendIsOnline.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            friendIsOnline.heightAnchor.constraint(equalToConstant: 10),
            friendIsOnline.widthAnchor.constraint(equalTo: friendIsOnline.heightAnchor)
            
        ])
    }

}

final class FriendsTab: UITableViewController {
    
    private var friendModel: [Friend] = []

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friendModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendReuseID") as? FriendCellIterator else {
            return UITableViewCell()
        }
        cell.updateCell(friend: friendModel[indexPath.row])
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Friends"
        tableView.register(FriendCellIterator.self, forCellReuseIdentifier: "friendReuseID")
        let ns = NetworkService()
        ns.getFriends { [weak self] friends in
            
            self?.friendModel = friends
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}
