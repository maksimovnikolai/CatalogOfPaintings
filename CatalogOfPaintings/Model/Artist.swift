//
//  Author.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 14.02.2024.
//

import Foundation

struct ArtistData: Decodable, Hashable {
    let artists: [Artist]
}

struct Artist: Decodable, Hashable {
    let name: String
    let image: String
    let bio: String
    let works: [Work]
}

struct Work: Decodable, Hashable {
    let title: String
    let image: String
    let info: String
}

