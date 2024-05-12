//
//  Created by Andy  on 2024-05-12.
//

import Foundation

struct Points {
    
    enum Multiplier: CGFloat {
        case x1 = 1
        case x2 = 2
        case x3 = 3
        case x4 = 4
        
        private var basePoint: CGFloat {
            8
        }
        
        var points: CGFloat {
            self.rawValue * basePoint
        }
    }
    
    static var x1: CGFloat {
        Multiplier.x1.points
    }
    
    static var x2: CGFloat {
        Multiplier.x2.points
    }
    
    static var x3: CGFloat {
        Multiplier.x3.points
    }
    
    static var x4: CGFloat {
        Multiplier.x4.points
    }
    

}
