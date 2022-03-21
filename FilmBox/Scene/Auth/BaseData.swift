//
//  BaseData.swift
//  FilmBox
//
//  Created by Ahmet Enes Irmak on 8.01.2022.
//

import Foundation

class BaseData{
    static let shared = BaseData()
    
    private init(){
        
    }
    
    var token:String?
}
