//
//  Post.swift
//  SuperSimpleMapper
//
//  Created by Frograin on 04/01/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

class Post {
    var title = "Post 1"
    var like = 10
    var comments: Array<Comment> = [Comment(), Comment()]
}
