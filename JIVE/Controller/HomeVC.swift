//
//  HomeVC.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class HomeVC: BaseViewController {
    
    @IBOutlet weak var feedTbl: UITableView!
    
    var expandable: [Int] = [0,0,0,0,0,0,0,0,0,0]
    var reportView: ReportAlert!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTbl.separatorStyle = .none
        feedTbl.allowsSelection = false
        feedTbl.register(UINib(nibName: "FECell", bundle: nil), forCellReuseIdentifier: "feCell")
        feedTbl.register(UINib(nibName: "FCCell", bundle: nil), forCellReuseIdentifier: "fcCell")
        
        reportView = ReportAlert(frame: self.view.frame)
        reportView.alpha = 0.0
        self.view.addSubview(reportView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActionView() {
        let alert = UIAlertController(title: "Choose Action", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Follow", style: .default, handler: { _ in
        }))
        
        alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { _ in
            let activityVC = UIActivityViewController(activityItems: ["Hi"], applicationActivities: nil)
            activityVC.excludedActivityTypes = [.airDrop, .addToReadingList]
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Report", style: .default, handler: { _ in
            self.reportView.fadeIn(completion: { (success) in
                
            })
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

}

extension HomeVC: UITableViewDelegate, UITableViewDataSource, FCCellDelegate {
    
    func showProfile(_ cell: FCCell) {
        self.appDelegate.makingRoot("gotoProfile")
    }
    
    func gotoDetail(_ cell: FCCell) {
        let vc = self.parent as! MainVC
        vc.actionShowStream()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.expandable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fcCell") as! FCCell
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 285.0
    }
    
    
}


