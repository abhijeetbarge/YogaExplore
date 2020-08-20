//
//  YogaViewController.swift
//  YogaExplore
//
//  Created by Abhijeet Barge on 20/08/20.
//  Copyright © 2020 Abhijeet Barge. All rights reserved.
//

import UIKit

 
protocol Back :class {
    func backAction()
}

class YogaViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    weak var backDelegate : Back?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblView.register(UINib.init(nibName: "YogaRatingsTableViewCell", bundle: nil), forCellReuseIdentifier: "YogaRatingsTableViewCell")
        
        self.tblView.register(UINib.init(nibName: "YogaAddressDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "YogaAddressDetailsTableViewCell")
    }
    
    @IBAction func back() {
        backDelegate?.backAction()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension YogaViewController :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "YogaRatingsTableViewCell", for: indexPath) as? YogaRatingsTableViewCell {
               return cell
            }
        }else if (indexPath.row == 1) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "YogaAddressDetailsTableViewCell", for: indexPath) as? YogaAddressDetailsTableViewCell {
               return cell
            }
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }else if indexPath.row == 1 {
            return 300
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
//            UIView.animate(withDuration: 0.5, delay: 0.5, options: .preferredFramesPerSecond30, animations: {
//                (cell as? YogaRatingsTableViewCell)?.imgView.alpha = 0.9
//            }, completion: nil)
            
            let starView = (cell as! YogaRatingsTableViewCell).starView!
            
            starView.pulse(withIntensity: 1.2, withDuration: 0.8, loop: false)
            
            let imgView = (cell as! YogaRatingsTableViewCell).imgView!
            let viewWidth = view.frame.width
            let viewHeight = view.frame.height
            UIView.animate(withDuration: 0.8) {
                imgView.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
            }
        }
    }
}


extension UIView {
    func pulse(withIntensity intensity: CGFloat, withDuration duration: Double, loop: Bool) {
        UIView.animate(withDuration: duration, delay: 0, options: [.repeat, .curveEaseInOut], animations: {
            loop ? nil : UIView.setAnimationRepeatCount(1)
            self.transform = CGAffineTransform(scaleX: intensity, y: intensity)
        }) { (true) in
            self.transform = CGAffineTransform.identity
        }
    }
}
