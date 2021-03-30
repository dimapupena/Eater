//
//  ConfigManager.swift
//  Eater
//
//  Created by Dmitriy Pupena on 23.03.2021.
//

import Foundation

class ConfigManager {
    var appConfiguration: AppConfiguration?
    
    static var sharer = ConfigManager()
    
    func loadData() {
        appConfiguration = loadJson(jsonFile: "addData")
    }
    
    func loadJson(jsonFile: String) -> AppConfiguration? {
       let decoder = JSONDecoder()
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let output = try? decoder.decode(AppConfiguration.self, from: data)
            else {
            return nil
        }

       return output
    }
}
