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

    func updateCell(photo: Photo) {
        
        DispatchQueue.global().async {
            
            if let url = URL(string: photo.sizes[2].url), let image = try? Data(contentsOf: url) {
                
                DispatchQueue.main.async {
                    self.photoCell.image = UIImage(data: image)
                }
            }
        }
    }

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
    private var photoModel: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCellIterator.self, forCellWithReuseIdentifier: "photoReuseID")
        
        let ns = NetworkService()
        ns.getPhotos { [weak self] photos in
            
            self?.photoModel = photos
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoReuseID", for: indexPath) as? PhotoCellIterator else {
            return UICollectionViewCell()
        }
        cell.updateCell(photo: photoModel[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoModel.count
    }
    
}


extension PhotosTab: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            let cellsize = UIScreen.main.bounds.width / 2 - 20
            return CGSize(width: cellsize, height: cellsize)
        }
}
