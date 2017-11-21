//
//  Category.swift
//  coder-swag
//
//  Created by Melanie Ren on 11/20/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import Foundation

struct Category {
    private(set) public var title: String
    private(set) public var imageName: String
    
    init(title: String, imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}
