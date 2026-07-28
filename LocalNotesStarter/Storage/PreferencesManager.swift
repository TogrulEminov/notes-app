//
//  PreferencesManager.swift
//  LocalNotesStarter
//
//  Created by Aysel Heydarova on 24.07.26.
//

import Foundation

final class PreferencesManager {
    static let shared = PreferencesManager()
    
    private let defaults = UserDefaults.standard
    
    private enum Keys {
        static let isDarkModeEnabled = "isDarkModeEnabled"
    }
    
    private init() { }
    
    var isDarkModeEnabled: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.isDarkModeEnabled)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.isDarkModeEnabled)
        }
    }
}


