//
//  PhotoRover.swift
//  ROVERNASAAPP
//
//  Created by Cristian guillermo Romero garcia on 04/12/23.
//

import Foundation

struct Photos: Codable{
    
    let photos: [PhotoRover]
    
    enum CodingKeys: String, CodingKey{
        case photos
    }
    
}

struct PhotoRover: Codable{
    struct Rover: Codable{
        let id: Int
        let name: String
        let landing_date: String
        let launch_date: String
        let status: String
        let total_photos: Int
    }
   

    struct Camera: Codable{
        let name: String
        let full_name: String?
    }
    
    let id: Int
    let sol: Int
    let image: String
    let earthDate: String?
    let rover: Rover
    let camera: Camera
    
    enum CodingKeys: String, CodingKey{
        case id
        case sol
        case image = "img_src"
        case earthDate
        case rover
        case camera
        
    }
}


