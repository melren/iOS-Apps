//
//  CategoryCell.swift
//  coder-swag
//
//  Created by Melanie Ren on 11/20/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    func updateViews(category: Category) {
        categoryImage.image = UIImage(named: category.imageName)
        categoryTitle.text = category.title
    }

}
