//
//  PhotoInfo.swift
//  ROVERNASAAPP
//
//  Created by Cristian guillermo Romero garcia on 06/12/23.
//

import Foundation

struct PhotoInfo: Codable{
    let title: String
    let date: String
    let copyright: String?
    let imageURL: String
    let description: String
    
    
    enum CodingKeys: String, CodingKey{
        case title
        case date
        case copyright
        case imageURL = "url"
        case description = "explanation"
    }
}
