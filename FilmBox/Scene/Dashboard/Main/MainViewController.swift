//
//  ViewController.swift
//  FilmBox
//
//  Created by Ahmet Enes Irmak on 3.01.2022.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var movieTableView: UITableView!
    
    var movieResponse: MovieResponse?
    var selectedMovie:Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        Network.getMovieData { response in
            self.movieResponse = response
            self.movieTableView.reloadData()
        } errorHandler: { error in
            print(error)
        }
        
    }


}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieResponse?.results?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Movie = movieResponse?.results?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.filmLabel.text = Movie?.title
        if let pictures = Movie?.posterPath {
                       cell.filmImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(pictures)"))

                       }

        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMovie = movieResponse?.results?[indexPath.row]
        performSegue(withIdentifier: "passVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "passVC" {
                    
                    let toVC = segue.destination as! ContentViewController
                    toVC.filmList = self.selectedMovie
                }
            }
    
}

