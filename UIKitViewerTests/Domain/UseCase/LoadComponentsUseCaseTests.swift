//
//  LoadComponentsUseCaseTests.swift
//  LoadComponentsUseCaseTests
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import XCTest
@testable import UIKitViewer

final class LoadComponentsUseCaseTests: XCTestCase {
    
    func test_LoadComponentUseCase_Load_Components() {
        let output = LoadComponentsUseCaseOutputMock()
        let useCase = LoadComponentsUseCase()
        useCase.output = output
        useCase.load()
        XCTAssertFalse(output.components.isEmpty)
    }
}

private extension LoadComponentsUseCaseTests {
    
    class LoadComponentsUseCaseOutputMock: LoadComponentsUseCaseOutput {
        
        var components = [Component]()
        func present(components: [Component]) {
            self.components = components
        }
    }
}
