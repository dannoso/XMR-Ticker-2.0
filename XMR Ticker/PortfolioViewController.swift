//
//  PortfolioViewController.swift
//  XMR Ticker
//
//  Created by John Woods on 22/01/2017.
//  Copyright © 2017 John Woods. All rights reserved.
//

import Cocoa

//protocol for data pass back
protocol PortfolioTrackingListener:class
{
    func portfolioTrackingStatusChanged(_ status:Bool)
    func portfolioCoinCountChanged(_ count:Double)
}

class PortfolioViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var coinCountTextField: NSTextField!
    @IBOutlet weak var trackingStatusCheckBox: NSButton!
    
    //delegate
    weak var delegate:PortfolioTrackingListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.coinCountTextField.delegate = self
    }
    override func viewDidDisappear() {
        self.delegate?.portfolioCoinCountChanged(Double(self.coinCountTextField.stringValue) ?? 0.00)

        switch self.trackingStatusCheckBox.state {
        case 1:
            self.delegate?.portfolioTrackingStatusChanged(true)
        case 0:
            self.delegate?.portfolioTrackingStatusChanged(false)
        default:
            self.delegate?.portfolioTrackingStatusChanged(true)
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        let charSet = NSCharacterSet(charactersIn: "1234567890.").inverted
        let chars = self.coinCountTextField.stringValue.components(separatedBy: charSet)
        self.coinCountTextField.stringValue = chars.joined()
    }
    
}
