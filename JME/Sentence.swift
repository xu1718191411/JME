//
//  Sentence.swift
//  JME
//
//  Created by xuzhongwei on 2018/12/03.
//  Copyright © 2018 xuzhongwei. All rights reserved.
//

import Foundation

public class Sentence{
    var content:String
    var time:NSDate
    var identiry:Identity
    
    init(_ content:String,_ time:NSDate,_ identity:Identity) {
        self.content = content
        self.time = time
        self.identiry = identity
    }
}

public enum Identity{
    case ME
    case YOU
}
