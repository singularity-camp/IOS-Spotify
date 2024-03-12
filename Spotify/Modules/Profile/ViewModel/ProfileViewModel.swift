//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by rauan on 3/1/24.
//

import Foundation

class ProfileViewModel {
    
    private var profileManager = ProfileManager.shared
    
    func getData(completion: @escaping (UserProfileModel)->Void){
        profileManager.getCurrentUserProfile { userData in
            completion(userData)
        }
    }
}
