//
//  FCOHelper.swift
//  FCO Sudoku
//
//  Created by Nguyễn Tấn Phúc on 1/5/18.
//  Copyright © 2018 Nguyễn Tấn Phúc. All rights reserved.
//

import Foundation

class FCOHelper {
    class func actionWithDelaytime(delayTime: Double, delayAction: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            delayAction()
        }
    }
    
    
}
