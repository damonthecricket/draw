//
//  ViewController.swift
//  Draw
//
//  Created by Damon Cricket on 20.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView?
    
    @IBOutlet weak var blackButton: UIButton?
    
    @IBOutlet weak var textField: UITextField?

    @IBOutlet weak var colorBottomConstraint: NSLayoutConstraint?
    
    var selectedButton: UIButton? = nil
    
    var color: UIColor? = nil
    
    var drawLayer: DrawLayer? = nil
    
    // MARK: - Object LifeCycle
    
    deinit {
        selectedButton = nil
        color = nil
        drawLayer = nil
    }
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        select(button: blackButton!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - UIActions
    
    @IBAction func panGestureRecognizer(sender: UIPanGestureRecognizer) {
        
        textField?.resignFirstResponder()
        
        let translation = sender.location(in: contentView!)
        
        switch sender.state {
        case .began:
            drawLayer = DrawLayer()
            drawLayer?.frame = contentView!.bounds
            drawLayer?.color = color!.cgColor
            let text = textField!.text
            drawLayer?.width = CGFloat(text != nil && !text!.isEmpty ? (text! as NSString).doubleValue : 0.0)
            drawLayer?.point = translation
            contentView?.layer.addSublayer(drawLayer!)
        case .changed:
            drawLayer?.point = translation
        case .ended, .cancelled, .failed, .possible:
            drawLayer = nil
        @unknown default:
            break
        }
    }

    @IBAction func blackButtonTap(sender: UIButton) {
        select(button: sender)
    }

    @IBAction func whiteButtonTap(sender: UIButton) {
        select(button: sender)
    }
    
    @IBAction func redButtonTap(sender: UIButton) {
        select(button: sender)
    }
    
    func select(button: UIButton) {
        selectedButton?.isSelected = false
        selectedButton = button
        selectedButton?.isSelected = true
        color = selectedButton!.backgroundColor!
    }
    
    // MARK: - Notification
    
    @objc func keyboardShowNotification(notification: Notification) {
        if let frame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            UIView.animate(withDuration: duration) {
                self.colorBottomConstraint?.constant = -frame.size.height
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardHideNotification(notification: Notification) {
        if let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            UIView.animate(withDuration: duration) {
                self.colorBottomConstraint?.constant = 0.0
                self.view.layoutIfNeeded()
            }
        }
    }
}
