//
//  NotificationVC.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class NotificationVC: BaseViewController {

    @IBOutlet weak var scrNotification: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        var item: NotificationCell?
        var last_item: NotificationCell?
        var offset_y: CGFloat = 0.0
        
        for i in 0 ..< 20 {
            if last_item != nil {
                offset_y = last_item!.frame.origin.y + last_item!.frame.height
            }
            var height: CGFloat = 40.0
            var showGradient: CGFloat = 0.0
            var type: Int = 1
            switch i {
            case 0:
                height = 40
                type = 0
                break
            case 3:
                height = 40
                type = 0
            default:
                height = 60
                if i == 1 {
                    showGradient = 1.0
                }
                break
            }
            item = NotificationCell(frame: CGRect(x: 0, y: offset_y, width: self.scrNotification.frame.width, height: height))
            item?.loadNibName(type)
            if type == 1 {
                item?.gradientBk.alpha = showGradient
                if i == 1 {
                    item?.lblDescription.textColor = UIColor.white
                    item?.lblTime.textColor = UIColor.white
                }
            }
            if i == 3 {
                item?.lblTitle.text = "Earlier"
            }
            last_item = item
            self.scrNotification.addSubview(item!)
            self.scrNotification.contentSize = CGSize(width: 0, height: last_item!.frame.origin.y + last_item!.frame.height)
        }
    }

}
