//
//  PreviewData.swift
//  CatAPI
//
//

import Foundation


class PreviewData {
    
    static func load<T : Codable>(filename: String) -> [T] {
        if let path = Bundle.main.path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let results = try JSONDecoder().decode([T].self, from: data)
                return results
            } catch {
                return []
            }
        }
        return []
    }
}
