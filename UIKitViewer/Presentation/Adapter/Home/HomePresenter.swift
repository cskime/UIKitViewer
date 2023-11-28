//
//  HomePresenter.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import Foundation

protocol HomeViewProtocol: AnyObject {
    func display(viewModel: HomeViewModel)
}

class HomePresenter {
    weak var view: HomeViewProtocol?
}


// MARK: - LoadComponentsUseCaseOutput

extension HomePresenter: LoadComponentsUseCaseOutput {
    
    func present(components: [Component]) {
        let viewModel = HomeViewModel(components: components.map(\.name))
        view?.display(viewModel: viewModel)
    }
}
