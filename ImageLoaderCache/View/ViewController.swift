//
//  ViewController.swift
//  ImageLoaderCache
//
//  Created by Extreme Agile on 11/05/24.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var collection_view: UICollectionView!
    // URL cache for disk caching
    let urlCache = URLCache.shared
    var viewModel: ImageViewModel?
    var model:ImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection_view.dataSource = self
        collection_view.delegate = self
        viewModel = ImageViewModel()
        Task.init {
            do {
                model = try await viewModel?.getImageUrls()
                collection_view.reloadData()
            } catch {
                
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCell
        let domain = model?[indexPath.row].thumbnail.domain
        let basePath = model?[indexPath.row].thumbnail.basePath
        let key = model?[indexPath.row].thumbnail.key
        let imageUrl = "\(domain ?? "")/\(basePath ?? "")/0/\(key ?? "")"
        cell.cellImage.setImage(with: URL(string: imageUrl)!, placeholder: UIImage(named: "image1"))
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
