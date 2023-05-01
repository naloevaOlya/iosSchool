//
//  LocationAssembly.swift
//  iosSchool
//
//  Created by student2 on 01.04.2023.
//

import Foundation

protocol LocationAssembly {
    func locationCoordinator() -> LocationCoordinator
    func locationVC() -> LocationViewController <LocationViewImp>
    func locationDataProvider() -> LocationDataProvider
    func profileDataProvider() -> ProfileDataProvider
}

extension Assembly: LocationAssembly {

    func locationCoordinator() -> LocationCoordinator {
        LocationCoordinator(assembly: self, context: .init())
    }

    func locationVC() -> LocationViewController <LocationViewImp> {
        .init(
            profileDataProvider: profileDataProvider(),
            dataProvider: locationDataProvider(),
            storageManager: storageManager
        )
    }

    func locationDataProvider() -> LocationDataProvider {
        LocationDataProviderImp(apiClient: apiClient)
    }

    func profileDataProvider() -> ProfileDataProvider {
        ProfileDataProviderImp(apiClient: apiClient)
    }
}
