//
//  ConfigManager.swift
//  Eater
//
//  Created by Dmitriy Pupena on 23.03.2021.
//

import Foundation
import Firebase

class ConfigManager {
    var appConfiguration: AppConfiguration?
    var dataWasSynchronized: Bool = false
    
    static var sharer = ConfigManager()
    
    func loadData(completion: ((Bool) -> Void)?) {
        loadJson(url: "appData.json", completion: completion)
    }
    
    private func loadJson(url: String, completion: ((Bool) -> Void)?) {
       let decoder = JSONDecoder()
        Storage.storage().reference(withPath: url).getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("get error \(error)")
                completion?(false)
            } else {
                guard let data = data else { return }
                self.appConfiguration = try? decoder.decode(AppConfiguration.self, from: data)
                self.dataWasSynchronized = true
                completion?(true)
            }
        }
    }
}
