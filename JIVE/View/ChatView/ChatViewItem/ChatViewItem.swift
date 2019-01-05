//
//  ChatViewItem.swift
//  JIVE
//
//  Created by RSS on 10/26/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class ChatViewItem: UIView {
    
    @IBOutlet weak var scrChatView: UIScrollView!
    @IBOutlet weak var supportView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadNibName(_ type: Int) {
        let view = Bundle.main.loadNibNamed("ChatViewItem", owner: self, options: nil)?[type] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        self.initView()
    }
    
    func initView() {
        var item: ChatViewCell?
        var last_item: ChatViewCell?
        var offset_y: CGFloat = 0
        for _ in 0 ..< 10 {
            if last_item != nil {
                offset_y = last_item!.frame.origin.y + last_item!.frame.height + 5
            }
            item = ChatViewCell(frame: CGRect(x: 0, y: offset_y, width: scrChatView.frame.width, height: 40))
            last_item = item
            self.scrChatView.addSubview(item!)
            self.scrChatView.contentSize = CGSize(width: 0, height: last_item!.frame.origin.y + last_item!.frame.height + 5)
        }
        supportView.clipsToBounds = true
        supportView.layer.cornerRadius = 5
        supportView.layer.borderColor = UIColor.white.cgColor
        supportView.layer.borderWidth = 1.0
    }
    
    @IBAction func actionGotoProfile(_ sender: UIButton) {
        let viewCon = self.findViewController() as! BaseViewController
        viewCon.appDelegate.makingRoot("gotoProfile")
    }
    
}
