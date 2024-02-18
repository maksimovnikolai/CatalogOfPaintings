//
//  Bundle+extension.swift
//  CatalogOfPaintings
//
//  Created by Nikolai Maksimov on 14.02.2024.
//

import Foundation

enum BundleError: Error {
    case invalidResources(String)
    case noContents(String)
    case decodingError(Error)
}

extension Bundle {
    
    func parseJSON(with name: String) throws -> [Artist] {
        
        // Bundle() позволяет получить доступ (читать) к ресурсам и файлам приложения, например, mp3-файлу или, в данном случае, файлу artists.json.
        
        // получить URL-адрес предполагаемых ресурсов
        // здесь нам нужен URL-адрес файла Artists.json
        guard let path = Bundle.main.path(forResource: name, ofType: ".json") else {
            throw BundleError.invalidResources(name)
        }
        
        guard let data = FileManager.default.contents(atPath: path) else {
            throw BundleError.noContents(path)
        }
        
        var artistData: ArtistData
        
        do {
            artistData = try JSONDecoder().decode(ArtistData.self, from: data)
        } catch {
            throw BundleError.decodingError(error)
        }
        
        return artistData.artists
    }
}
