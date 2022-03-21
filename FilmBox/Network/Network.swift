//
//  Network.swift
//  FilmBox
//
//  Created by Ahmet Enes Irmak on 4.01.2022.
//

import Foundation
import Alamofire

class Network{
    
    static func getMovieData(complationHandler:@escaping (MovieResponse)->(), errorHandler:@escaping (String)->()){
        AF.request("https://api.themoviedb.org/3/discover/movie?api_key=4e327d95ae9fe00905bdafe0f8287338").responseDecodable { (response:AFDataResponse<MovieResponse>) in
            switch response.result{
                case .success(let movieResponse):
                complationHandler(movieResponse)
                case .failure(let error):
                errorHandler(error.localizedDescription)
                    print(error)
                break
            }
        }
    }
    
}


