//
//  ProfilePageViewModel.swift
//  Shopee
//
//  Created by Berksu Kısmet on 31.10.2022.
//

import UIKit

final class ProfilePageViewModel{
    enum ProfilePageViewModelChanges{
        case didFetchUserInfoSuccessfully(_ user: UserProfile)
        case didErrorOccurred(_ error: Error)
    }

    var changeHandler: ((ProfilePageViewModelChanges) -> Void)?
    
    var user: UserProfile?{
        FirebaseAuthentication.shared.userInfo
    }
}
