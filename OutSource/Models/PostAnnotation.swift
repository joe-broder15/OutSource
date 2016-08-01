//
//  PostAnnotation.swift
//  OutSource
//
//  Created by JoeB on 7/30/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import MapKit

class PostAnnotation: MKPointAnnotation {
    let post: Post
    let image: UIImage
    
    init(post: Post, image: UIImage) {
        self.post = post
        self.image = image
        super.init()
    }
}