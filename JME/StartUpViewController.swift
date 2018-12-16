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
    var isSlide:Bool = false
    var isShown: Bool {
        return self.SideMenuConstraint.constant == -230
    }
    private var contentMaxWidth: CGFloat {
        return view.bounds.width * 0.8
    }
    private var contentRatio: CGFloat {
        get {
            return contentView.frame.maxX / contentMaxWidth
        }
        set {
            let ratio = min(max(newValue, 0), 1)
            contentView.frame.origin.x = contentMaxWidth * ratio - contentView.frame.width
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowRadius = 3.0
            contentView.layer.shadowOpacity = 0.8
            
            view.backgroundColor = UIColor(white: 0, alpha: 0.3 * ratio)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var sideMenuController =  self.children[1] as! SideMenuViewController
        
        var mainViewController =  self.children[0] as! ViewController
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
            showSideMenu(true)
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
//                    showContentView(animated: true)
                    showSideMenu(true)
                } else {
                    //self.delegate?.sidemenuViewControllerDidRequestHiding(self, animated: true)
                    hideSideMenu(true)
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
    
    func hideSideMenu(_ animation:Bool){
        SideMenuConstraint.constant = -230
        if(animation){
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func showSideMenu(_ animation:Bool){
        SideMenuConstraint.constant = 0
        if(animation){
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func toggleSideMenu(){
        
        if(isSlide){
            SideMenuConstraint.constant = -230
        }else{
            SideMenuConstraint.constant = 0
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        isSlide = !isSlide
    }
    
    

}

extension StartUpViewController:SideMenuProtocol{
    func slide() {
        toggleSideMenu()
    }
}


extension StartUpViewController:UIGestureRecognizerDelegate{
    internal func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
