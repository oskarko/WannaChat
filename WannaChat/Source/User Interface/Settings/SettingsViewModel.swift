//  SettingsViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class SettingsViewModel {
    
    // MARK: - Properties
    
    weak var view: SettingsViewControllerProtocol?
    var router: SettingsRouter?
    
    // MARK: - Helpers
    
    func getIdentifier(for indexPath: IndexPath) -> String? {
        guard let sectionType = SettingsSectionType(rawValue: indexPath.section) else { return nil }
        
        switch sectionType {
        case .header: return SettingsHeaderType(rawValue: indexPath.row)?.identifier
        case .button: return SettingsButtonType(rawValue: indexPath.row)?.identifier
        case .text: return SettingsTextType(rawValue: indexPath.row)?.identifier
        }
    }
    
    func numberOfSections() -> Int {
        SettingsSectionType.allCases.count
    }
    
    func heightForHeader(at section: Int) -> Int {
        section == 0 ? 0 : 10
    }
    
    func numberOfRows(at section: Int) -> Int {
        guard let sectionType = SettingsSectionType(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .header: return SettingsHeaderType.allCases.count
        case .button: return SettingsButtonType.allCases.count
        case .text: return SettingsTextType.allCases.count
        }
    }
    
    func getCellTitle(for indexPath: IndexPath) -> String? {
        guard let sectionType = SettingsSectionType(rawValue: indexPath.section) else { return nil }
        
        switch sectionType {
        case .header: return nil
        case .button: return SettingsButtonType(rawValue: indexPath.row)?.titleString
        case .text: return SettingsTextType(rawValue: indexPath.row)?.titleString
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> Int {
        guard let sectionType = SettingsSectionType(rawValue: indexPath.section) else { return 0 }
        
        switch sectionType {
        case .header: return SettingsHeaderType(rawValue: indexPath.row)?.height ?? 0
        case .button: return SettingsButtonType(rawValue: indexPath.row)?.height ?? 0
        case .text: return SettingsTextType(rawValue: indexPath.row)?.height ?? 0
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard
            let sectionType = SettingsSectionType(rawValue: indexPath.section),
                sectionType == .header
        else { return }
        
        router?.showEditProfileView()
    }
}

// MARK: - SettingsLogOutCellDelegate

extension SettingsViewModel: SettingsLogOutCellDelegate {
    func logOutButtonTapped() {
        FirebaseUserListener.shared.logOutCurrentUser { [weak self] error in
            guard let self = self, error == nil else { return }
            
            self.router?.showLoginView()
        }
    }
}
