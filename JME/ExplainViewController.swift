//
//  ExplainViewController.swift
//  JME
//
//  Created by xuzhongwei on 2018/12/10.
//  Copyright © 2018 xuzhongwei. All rights reserved.
//

import UIKit

class ExplainViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var englishExplain: UITextView!
    
    @IBOutlet weak var japaneseExplain: UITextView!
    
    var parameter: Sentence?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        englishExplain.text = parameter?.englishExplanation
        japaneseExplain.text = parameter?.japaneseExplanation
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func close(_ sender: UIButton) {
        
        dismiss(animated: true) {
            
        }
        
    }
    
    

}
