//
//  PhotosTab.swift
//  lab01-1
//
//  Created by Ринат Мурзалиев on 21.01.2024.
//

import UIKit

final class PhotoCellIterator: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoCell)
        setConstrs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var photoCell = UIImageView(image: UIImage(named: "login"))
    
    private func setConstrs(){
        photoCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoCell.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            photoCell.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
}

final class PhotosTab: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCellIterator.self, forCellWithReuseIdentifier: "photoReuseID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoReuseID", for: indexPath) as? PhotoCellIterator else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
}


extension PhotosTab: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            let cellsize = UIScreen.main.bounds.width / 2 - 20
            return CGSize(width: cellsize, height: cellsize)
        }
}
