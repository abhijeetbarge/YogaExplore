
//
//  CustomTabBarControllerViewController.swift
//  YogaExplore
//
//  Created by Abhijeet Barge on 19/08/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import UIKit

class CustomTabBarController: UIViewController,Back {

    @IBOutlet weak var bottomBarView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    var yogaViewController: YogaViewController!
    var chatViewController: UIViewController!
    var artclesViewController: UIViewController!
    var settingsViewController: UIViewController!
    
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        yogaViewController = storyboard.instantiateViewController(withIdentifier: "YogaViewController") as? YogaViewController
        yogaViewController.backDelegate = self
        chatViewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController")
        artclesViewController = storyboard.instantiateViewController(withIdentifier: "ArticlesViewController")
        settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        
        viewControllers = [yogaViewController, chatViewController, artclesViewController, settingsViewController]
        
        buttons[selectedIndex].isSelected = true
        tabPressed(sender: buttons[selectedIndex])

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bottomBarView.roundCorners(corners: [ .topRight, .topLeft], radius: 40)
    }
    
    @IBAction func tabPressed(sender:UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        
        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

}
