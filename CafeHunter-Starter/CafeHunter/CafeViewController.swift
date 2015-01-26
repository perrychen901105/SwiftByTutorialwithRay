//
//  CafeViewController.swift
//  CafeHunter
//
//  Created by chenzhipeng on 15/1/26.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import UIKit

@objc protocol CafeViewControllerDelegate {
    optional func cafeViewControllerDidFinish(viewController: CafeViewController)
}

class CafeViewController: UIViewController {

    weak var delegate: CafeViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStreet: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblZip: UILabel!
    
    @IBAction private func back(sender: AnyObject) {
        // if the delegate property is nil then this expression will do nothing. if the delegate is set but not implement also do nothing.
        self.delegate?.cafeViewControllerDidFinish?(self)
    }
    
    var cafe: Cafe? {
        didSet {
            self.setupWithCafe()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWithCafe()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupWithCafe() {
        // 1
        if !self.isViewLoaded() {
            return
        }
        
        // 2
        if let cafe = self.cafe {
            // 3
            self.title = cafe.name
            self.lblName.text = cafe.name
            self.lblStreet.text = cafe.street
            self.lblCity.text = cafe.city
            self.lblZip.text = cafe.zip
            
            // 4
            let request = NSURLRequest(URL: cafe.pictureURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                let image = UIImage(data: data)
                self.imageView.image = image
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
