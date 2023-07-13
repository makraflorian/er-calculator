//
//  StringExtension.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 07. 12..
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    static var loremipsum: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut luctus ligula eget lectus tincidunt pulvinar. Maecenas et arcu blandit, feugiat tellus at, ultricies sapien. Aliquam quis nisl leo. Phasellus vel mollis quam. Fusce viverra commodo porta. Praesent elementum tempor turpis at interdum. Etiam quis ex eget lacus vehicula faucibus. Nam eleifend metus sit amet tortor suscipit elementum. In maximus elit eget neque facilisis lobortis. Phasellus volutpat elit a lectus porta, eu faucibus libero congue. Sed in tristique tortor. Cras porttitor felis sed finibus mollis. Curabitur pellentesque augue tortor, volutpat feugiat velit vulputate et."
    }
}
