//
//  FeedDetailVC.swift
//  JIVE
//
//  Created by RSS on 9/17/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class FeedDetailVC: BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionShare(_ sender: UIButton) {
        let activityVC = UIActivityViewController(activityItems: ["Hi"], applicationActivities: nil)
        activityVC.excludedActivityTypes = [.airDrop, .addToReadingList]
        activityVC.popoverPresentationController?.sourceView = sender
        self.present(activityVC, animated: true, completion: nil)
    }
    
}
