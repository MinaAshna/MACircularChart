//
//  ConvertToTrigonometry.swift
//  circularProgress
//
//  Created by Mina Ashena on 12/7/1395 AP.
//  Copyright © 1395 MA. All rights reserved.
//

import Foundation
import UIKit

class ConvertToTrigonometry {
    
    static let shared = ConvertToTrigonometry()
    
    func trigonimetryCordinate(percentage: CGFloat) -> CGFloat {
        let pi = CGFloat.pi
        let trigonometryRatio = (percentage * 360) / 100 // How much you want to move forward in axis.
        let endPointDegree = (3 * pi / 2) + ((trigonometryRatio * 2 / 360) * pi) // End point on axis based on your trigonometryRatio and the start point which is 3pi/2
        return endPointDegree
    }
}
