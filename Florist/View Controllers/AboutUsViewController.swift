//
//  AboutUsViewController.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import MessageUI
import ProgressHUD

class AboutUsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var aboutUsTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    @IBAction func tellAFriendBarButtonPressed(_ sender: UIBarButtonItem) {
 
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
           // mail.setToRecipients(["test@test.test"])
            mail.setSubject("Flower power - check out this iPhone app!")
            mail.setMessageBody("<p>Is it time to send flowers? Get \"brownie\" points by sending flowers with this colorful app.<p><br /><p><a href=\"http://appstore.com/florist\">http://appstore.com/florist</a><br /><br /><p>Send flowers to anyone in Miami, Florida and you don't need to pay shipping!", isHTML: true)
            present(mail, animated: true, completion: nil)
        } else {
            // give feedback to the user
            ProgressHUD.showError("Something went wrong. Please try again later and make sure you are connected to the internet.")
        }
        
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
        
    
}
