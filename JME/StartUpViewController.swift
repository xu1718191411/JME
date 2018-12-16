//
//  StartUpViewController.swift
//  JME
//
//  Created by xuzhongwei on 2018/12/16.
//  Copyright © 2018 xuzhongwei. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {

    @IBOutlet weak var SideMenuConstraint: NSLayoutConstraint!

    private let contentView = UIView(frame: .zero)
    private var screenEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var beganLocation: CGPoint = .zero
    private var beganState: Bool = false
    private var sideMenuController:SideMenuViewController!
    private var mainViewController:ViewController!
    
    var isSlide:Bool = false
    var isShown: Bool {
        return self.SideMenuConstraint.constant != -230
    }
    private var contentMaxWidth: CGFloat {
        return view.bounds.width * 0.8
    }
    private var contentRatio: CGFloat {
        get {
            return (SideMenuConstraint.constant + 230) / 230
        }
        set {
            let ratio = min(max(newValue, 0), 1)
            sideMenuController.view.layer.shadowColor = UIColor.black.cgColor
            sideMenuController.view.layer.shadowRadius = 3.0
            sideMenuController.view.layer.shadowOpacity = 0.8
            SideMenuConstraint.constant = -230 + ratio * 230

        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuController =  self.children[1] as! SideMenuViewController
        mainViewController =  self.children[0] as! ViewController
        // Do any additional setup after loading the view.
        
        mainViewController.delegate = self
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(sender:)))
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
        
        
        startPanGestureRecognizing()
        
    }
    
    
    @objc private func backgroundTapped(sender: UITapGestureRecognizer) {
        
    }
    
    @objc private func panGestureRecognizerHandled(panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: view)
        if translation.x > 0 && contentRatio == 1.0 {
            return
        }
        
        let location = panGestureRecognizer.location(in: view)
        
        switch panGestureRecognizer.state {
        case .began:
            beganState = isShown
            beganLocation = location
            if translation.x  >= 0 {
//                self.delegate?.sidemenuViewControllerDidRequestShowing(self, contentAvailability: false, animated: false)
            //showSideMenu(true)
            }
        case .changed:
            let distance = beganState ? beganLocation.x - location.x : location.x - beganLocation.x
       
            if distance >= 0 {
                let ratio = distance / (beganState ? beganLocation.x : (view.bounds.width - beganLocation.x))
                let contentRatio = beganState ? 1 - ratio : ratio
                self.contentRatio = contentRatio
            }
            
        case .ended, .cancelled, .failed:

            if contentRatio <= 1.0, contentRatio >= 0 {
                if location.x > beganLocation.x {
                   
                  showContentView(animated: true)
         
//                  self.SideMenuConstraint.constant = 0
//                  UIView.animate(withDuration: 0.3) {
//                         self.view.layoutIfNeeded()
//                  }
                    
                } else {

                    hideContentView(animated: true) { (Bool) in
                        
                    }
                }
            }
            beganLocation = .zero
            beganState = false
        default: break
        }
        
    }
    
    func startPanGestureRecognizing(){
        screenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandled(panGestureRecognizer:)))
        screenEdgePanGestureRecognizer.edges = [.left]
        screenEdgePanGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(screenEdgePanGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandled(panGestureRecognizer:)))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    func showContentView(animated: Bool) {
        if animated {
            self.contentRatio = 1.0
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        } else {
            contentRatio = 1.0
        }
    }
    
    func hideContentView(animated: Bool, completion: ((Bool) -> Swift.Void)?) {
        if animated {
            self.contentRatio = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                completion?(finished)
            })
        } else {
            contentRatio = 0
            completion?(true)
        }
    }

}

extension StartUpViewController:SideMenuProtocol{
    func slide() {
    
    }
}


extension StartUpViewController:UIGestureRecognizerDelegate{
    internal func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
