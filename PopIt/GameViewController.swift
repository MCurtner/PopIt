//
//  GameViewController.swift
//  PopIt
//
//  Created by Matthew Curtner on 12/12/15.
//  Copyright (c) 2015 Matthew Curtner. All rights reserved.
//

import UIKit
import SpriteKit
import iAd

class GameViewController: UIViewController, GameDelegate {
    
    var continueMode: Bool?
    var newImage: UIImage?
    
    // Share
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.hidden = true
        
        UIViewController.prepareInterstitialAds()
        self.interstitialPresentationPolicy = .Manual
        
        
        let scene = GameScene(size: view.bounds.size)
        
        // Configure the view.
        let skView = self.view as! SKView
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        
        if let continueIsTrue = continueMode {
            scene.continueMode = continueIsTrue
        }
        
        scene.gameDelegate = self
        
        skView.presentScene(scene)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func gameStarted() {
        shareButton.hidden = true
    }
    
    func gameFinished() {
        snapPic()
        shareButton.hidden = false
        self.requestInterstitialAdPresentation()
    }
    
    func share(image: UIImage) {
        let avc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone {
            self.presentViewController(avc, animated: true, completion: nil)
        }
        else {
            avc.modalPresentationStyle = UIModalPresentationStyle.Popover
            avc.popoverPresentationController?.sourceView = self.shareButton
            self.presentViewController(avc, animated: true, completion: nil)
        }
    }
    
    func snapPic() {
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 1.0)
        self.view.drawViewHierarchyInRect(CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), afterScreenUpdates: false)
        newImage = UIGraphicsGetImageFromCurrentImageContext()
    }
    
    @IBAction func menuButtonHandler(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButtonHandler(sender: AnyObject) {
        if let image = newImage {
            share(image)
        }
    }
}
