//
//  PostButton.swift
//  OutSource
//
//  Created by JoeB on 8/1/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class PostButton: UIButton {
    
    var post: Post? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
      
    }
    
}
