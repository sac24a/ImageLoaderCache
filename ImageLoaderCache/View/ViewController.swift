//
//  ViewController.swift
//  ImageLoaderCache
//
//  Created by Sachin Kanojia on 11/05/24.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var collection_view: UICollectionView!
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
            } catch let error {
                print(error)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        DispatchQueue.main.async {
            let domain = self.model?[indexPath.row].thumbnail.domain
            let basePath = self.model?[indexPath.row].thumbnail.basePath
            let key = self.model?[indexPath.row].thumbnail.key
            let imageUrl = "\(domain ?? "")/\(basePath ?? "")/0/\(key ?? "")"
            cell.cellImage.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "placeholder"))
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = view.frame.size.height
            let width = view.frame.size.width
        return CGSize(width: width * 0.3, height: height * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
} 

