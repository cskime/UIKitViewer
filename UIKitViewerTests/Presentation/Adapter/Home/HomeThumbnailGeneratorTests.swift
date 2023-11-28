//
//  HomeThumbnailGeneratorTests.swift
//  UIKitViewerTests
//
//  Created by chamsol kim on 11/26/23.
//  Copyright © 2023 cskim. All rights reserved.
//

import XCTest

final class HomeThumbnailGeneratorTests: XCTestCase {

    func testExample() throws {
        guard let viewType = NSClassFromString("UILabel") as? UILabel.Type else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(viewType is UILabel.Type)
    }
}
