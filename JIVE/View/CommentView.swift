//
//  CommentView.swift
//  JIVE
//
//  Created by RSS on 9/18/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class CommentView: UIScrollView {
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addComments()
    }
    func addComments() {
        var item: CommentCell?
        var last_item: CommentCell?
        var offset_y: CGFloat = 0
        for _ in 0 ..< 20 {
            if last_item != nil {
                offset_y = last_item!.frame.origin.y + last_item!.frame.height
            }
            item = CommentCell(frame: CGRect(x: 0, y: offset_y, width: self.frame.width, height: 35))
            last_item = item
            self.addSubview(item!)
            self.contentSize = CGSize(width: 0, height: last_item!.frame.origin.y + last_item!.frame.height)
        }
    }
}
