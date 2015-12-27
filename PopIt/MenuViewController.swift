//
//  MenuViewController.swift
//  PopIt
//
//  Created by Matthew Curtner on 12/12/15.
//  Copyright © 2015 Matthew Curtner. All rights reserved.
//

import UIKit
import iAd
import GameKit

class MenuViewController: UIViewController, GKGameCenterControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateLocalPlayer()
        
        print(NSUserDefaults.standardUserDefaults().integerForKey("maxLevel"))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playButtonHandler(sender: AnyObject) {
        let gvc = storyboard?.instantiateViewControllerWithIdentifier("gameViewController") as! GameViewController
        gvc.continueMode = false
        presentViewController(gvc, animated: true, completion: nil)
        
    }
    
    @IBAction func continueButtonHandler(sender: AnyObject) {
        let gvc = storyboard?.instantiateViewControllerWithIdentifier("gameViewController") as! GameViewController
        gvc.continueMode = true
        presentViewController(gvc, animated: true, completion: nil)
    }

    @IBAction func showLeaderBoard(sender: AnyObject) {
        let vc = self.view.window?.rootViewController
        let gc = GKGameCenterViewController()
        
        gc.gameCenterDelegate = self
        vc?.presentViewController(gc, animated: true, completion: nil)
    }
    
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = { (viewController, error) -> Void in
            if viewController != nil {
                self.presentViewController(viewController!, animated: true, completion: nil)
            } else {
                print(error)
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
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
