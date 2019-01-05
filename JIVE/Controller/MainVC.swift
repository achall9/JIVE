//
//  MainVC.swift
//  JIVE
//
//  Created by RSS on 9/10/18.
//  Copyright © 2018 LOVI. All rights reserved.
//

import UIKit

class MainVC: BaseViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var tabButtons: [UIButton]!
    
    var donationView: UIView?
    var chat_view: ChatView?
    var chatView: [ChatView] = []
    
    var prevBtn: Int = 0
    var viewcontrollers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if donationView == nil {
            donationView = UIView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height))
            self.view.addSubview(donationView!)
        }
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let notificationVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        let feedDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedDetailVC") as! FeedDetailVC
        
        self.viewcontrollers = [homeVC, notificationVC, profileVC, feedDetailVC]
        self.actionClickTab(tabButtons[self.appDelegate.currentView])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionClickTab(_ sender: UIButton) {
        let previousVC = self.viewcontrollers[prevBtn]
        let newVC = self.viewcontrollers[sender.tag]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        addChildViewController(newVC)
        self.prevBtn = sender.tag
        //if sender.tag > 3 {
        //    self.animatePushDismissTransition(to: newVC)
        //}else {
            self.animateFadeDismissTransition(to: newVC)
        //}
    }
    
    func actionShowStream() {
        if chat_view != nil {
            chat_view?.removeFromSuperview()
            chat_view = nil
        }
        chat_view = ChatView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height))
        chat_view?.loadNibName(0)
        self.view.addSubview(chat_view!)
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.chat_view?.transform = CGAffineTransform(translationX: 0, y: -self.chat_view!.frame.height)
        }, completion: { (finished) -> Void in
            if finished{
                
            }
        })
    }
    
    @IBAction func actionDonate(_ sender: UIButton) {
        
        donationView?.subviews.forEach({ (view) in
            if view is ChatView {
                view.removeFromSuperview()
            }
        })
        chatView.removeAll()
        for i in 1 ..< 3 {
            let view = ChatView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            view.delegate = self
            view.loadNibName(i)
            chatView.append(view)
            donationView?.addSubview(chatView[i - 1])
        }
        
        chatView[0].isHidden = false
        chatView[1].isHidden = true
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.donationView?.transform = CGAffineTransform(translationX: 0, y: -self.donationView!.frame.height)
        }, completion: { (finished) -> Void in
            if finished{
                
            }
        })
    }
    
    func animateFadeDismissTransition(to newVC: UIViewController) {
        newVC.view.frame = self.containerView.bounds
        self.containerView.alpha = 0.0
        self.containerView.addSubview(newVC.view)
        DispatchQueue.main.async {
            newVC.didMove(toParentViewController: self)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.containerView.alpha = 1.0
            }, completion: { (finished: Bool) in

            })
        }
    }
    
    func animatePushDismissTransition(to newVC: UIViewController) {
        newVC.view.frame = CGRect(x: self.containerView.bounds.width * 2, y: self.containerView.bounds.origin.y, width: self.containerView.bounds.width, height: self.containerView.bounds.height)
        self.containerView.addSubview(newVC.view)
        newVC.didMove(toParentViewController: self)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            newVC.view.frame = self.containerView.bounds
        }, completion: { (finished: Bool) in
            
        })
    }
}

extension MainVC: ChatViewDelegate {
    func actoionRotate(_ type: Int) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: chatView[type], duration: 1.0, options: transitionOptions, animations: {
            self.chatView[type].isHidden = true
        }) { (success) in
            
        }
        UIView.transition(with: chatView[2 - type], duration: 1.0, options: transitionOptions, animations: {
            self.chatView[2 - type].isHidden = false
        }) { (success) in
            
        }
    }
    
    func actionClose() {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.donationView?.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: { (finished) -> Void in
            if finished{
                
            }
        })
    }
}
