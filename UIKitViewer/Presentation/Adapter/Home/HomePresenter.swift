//
//  HomePresenter.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import Foundation

struct HomePresenter {
    
}


// MARK: - LoadComponentsUseCaseOutput

extension HomePresenter: LoadComponentsUseCaseOutput {
    
    func present(components: [Component]) {
        print(components)
    }
}
