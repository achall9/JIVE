//
//  BrowseVC.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class BrowseVC: BaseViewController {

    @IBOutlet weak var scrBrowse: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        var item: BrowseCell?
        var last_item: BrowseCell?
        var offset_y: CGFloat = 0
        for _ in 0 ..< 20 {
            if last_item != nil {
                offset_y = last_item!.frame.origin.y + last_item!.frame.height
            }
            item = BrowseCell(frame: CGRect(x: 0, y: offset_y, width: self.scrBrowse.frame.width, height: 60))
            last_item = item
            self.scrBrowse.addSubview(item!)
            self.scrBrowse.contentSize = CGSize(width: 0, height: last_item!.frame.origin.y + last_item!.frame.height)
        }
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
