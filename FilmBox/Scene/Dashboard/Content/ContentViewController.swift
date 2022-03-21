//
//  ContentViewController.swift
//  FilmBox
//
//  Created by Ahmet Enes Irmak on 7.01.2022.
//

import UIKit
import Kingfisher

class ContentViewController: UIViewController {

    var filmList : Response?
    
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelnfo: UILabel!
    @IBOutlet weak var viewOverview: UITextView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieListed : [Response]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
       
        
        if let fi = filmList,let images = filmList?.posterPath ,let bigImages = filmList?.backdropPath {
                    labelTitle.text = fi.title
                    viewOverview.text = fi.overview
                    labelnfo.text = "\(fi.releaseDate!)"
                    imageContent.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(bigImages)"))
                }
        
        Network.getMovieData { movieResponse in
            self.movieListed = movieResponse.results
            self.collectionView.reloadData()
//            print(self.movieListed)
        } errorHandler: { Err in
            print(Err)
        }

        // Do any additional setup after loading the view.
    }
    
    
}

extension ContentViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieListed?.count ?? 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.releasedImages.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movieListed?[indexPath.row].posterPath ?? "")"))
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.labelTitle.text = movieListed?[indexPath.row].title
        self.viewOverview.text = movieListed?[indexPath.row].overview
        self.labelnfo.text = movieListed?[indexPath.row].releaseDate
        self.imageContent.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(movieListed?[indexPath.row].backdropPath ?? "")"))
    }
    
    
    
}
