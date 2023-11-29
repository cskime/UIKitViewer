//
//  LoadComponentsUseCaseOutput.swift
//  UIKitViewer
//
//  Created by chamsol kim on 11/29/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import Foundation

protocol LoadComponentsUseCaseOutput {
    func present(response: LoadComponentsUseCase.Response)
}

extension LoadComponentsUseCase {
    
    struct Response {
        let components: [String]
    }
}
