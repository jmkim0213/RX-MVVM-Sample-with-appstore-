//
//  KKBAlertViewController.swift
//  AppStore
//
//  Created by Kim JungMoo on 27/01/2019.
//  Copyright © 2019 Kim JungMoo. All rights reserved.
//

import Foundation
import UIKit

class KKBAlertController {
    typealias ActionHandler = (UIAlertAction) -> Void
    
    var alertController                 : UIAlertController
    var presentingController            : UIViewController?     = nil
    
    var configuredPopoverController     : Bool = false
    var hasRequiredTextField            : Bool = false
    var alertPrimaryAction              : UIAlertAction?
    
    var title: String? {
        set { self.alertController.title = newValue }
        get { return alertController.title }
    }
    var message: String? {
        set { self.alertController.message = newValue }
        get { return self.alertController.message }
    }
    
    var tintColor: UIColor? {
        set { self.alertController.view.tintColor = newValue }
        get { return self.alertController.view.tintColor }
    }
    
    public init(style: UIAlertController.Style) {
        self.alertController = UIAlertController(title: nil, message: nil, preferredStyle: style)
    }
    
    @discardableResult
    func addAction(_ title: String, style: UIAlertAction.Style, handler: ActionHandler? = nil) -> KKBAlertController {
        return addAction(title, style: style, preferredAction: false, handler: handler)
    }
    
    @discardableResult
    func addAction(_ title: String, style: UIAlertAction.Style, preferredAction: Bool = false, handler: ActionHandler? = nil) -> KKBAlertController {
        var action: UIAlertAction
        if let handler = handler {
            action = UIAlertAction(title: title, style: style, handler: handler)
        } else {
            action = UIAlertAction(title: title, style: style, handler: { _ in })
        }
        self.alertController.addAction(action)
        if preferredAction {
            self.alertController.preferredAction = action
            if self.hasRequiredTextField {
                action.isEnabled = false
                self.alertPrimaryAction = action
            }
        }
        
        return self
    }
    
    func presentIn(_ source: UIViewController) -> KKBAlertController {
        self.presentingController = source
        return self
    }
    
    func show(animated: Bool = true, completion: (() -> Void)? = nil ) {
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            var presentedController = viewController
            while let presented = presentedController.presentedViewController, presentedController.presentedViewController?.isBeingDismissed == false {
                presentedController = presented
            }
            
            if self is ActionSheet && !self.configuredPopoverController,  let popoverController = alertController.popoverPresentationController {
                var topController = presentedController
                while let last = topController.children.last {
                    topController = last
                }
                popoverController.sourceView = topController.view
                popoverController.sourceRect = topController.view.bounds
            }
            
            if let source = self.presentingController { presentedController = source }
            DispatchQueue.main.async {
                presentedController.present(self.alertController, animated: animated, completion: completion)
            }
        }
    }
    
    func getAlertController() -> UIAlertController { return self.alertController }
}

class Alert: KKBAlertController {
    
    init(title: String? = nil, message: String? = nil) {
        super.init(style: .alert)
        self.title = title ?? (message ?? "")
        self.message = message
    }
    
    @discardableResult
    func addAction(_ title: String) -> Alert { return addAction(title, style: .default, preferredAction: false, handler: nil) }
    
    @discardableResult
    override func addAction(_ title: String, style: UIAlertAction.Style, handler: ActionHandler? = nil) -> Alert {
        return addAction(title, style: style, preferredAction: false, handler: handler)
    }
    
    @discardableResult
    override func addAction(_ title: String, style: UIAlertAction.Style, preferredAction: Bool, handler: ActionHandler? = nil) -> Alert {
        return super.addAction(title, style: style, preferredAction: preferredAction, handler: handler) as? Alert ?? self
    }
    
    @discardableResult
    func addTextField(_ textField: inout UITextField, required: Bool = false) -> Alert {
        var field : UITextField?
        self.alertController.addTextField { [unowned textField] (tf: UITextField) in
            tf.text = textField.text
            tf.placeholder = textField.placeholder
            tf.font = textField.font
            tf.textColor = textField.textColor
            tf.isSecureTextEntry = textField.isSecureTextEntry
            tf.keyboardType = textField.keyboardType
            tf.autocapitalizationType = textField.autocapitalizationType
            tf.autocorrectionType = textField.autocorrectionType
            field = tf
        }
        if required {
            let _ = NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: field, queue: OperationQueue.main, using: { (_) in
                if let actionButton = self.alertPrimaryAction { actionButton.isEnabled = field?.text?.isEmpty == false }
            })
            self.hasRequiredTextField = true
        }
        
        if let field = field { textField = field }
        return self
    }
    
    @discardableResult
    override func presentIn(_ source: UIViewController) -> Alert { return super.presentIn(source) as? Alert ?? self }
    
    @discardableResult
    func tint(_ color: UIColor) -> Alert {
        self.tintColor = color
        return self
    }
    
    func showOkay() {
        super.addAction("확인", style: .cancel, preferredAction: false, handler: nil)
        show()
    }
}

class ActionSheet : KKBAlertController {
    init(title: String? = nil, message: String? = nil) {
        super.init(style: .actionSheet)
        self.title     = title ?? (message == nil ? nil : "")
        self.message     = message
    }
    
    @discardableResult
    func addAction(_ title: String) -> ActionSheet { return addAction(title, style: .cancel, handler: nil) }
    
    @discardableResult
    override func addAction(_ title: String, style: UIAlertAction.Style, handler: KKBAlertController.ActionHandler?) -> ActionSheet {
        return addAction(title, style: style, preferredAction: false, handler: handler)
    }
    
    @discardableResult
    override func addAction(_ title: String, style: UIAlertAction.Style, preferredAction: Bool, handler: KKBAlertController.ActionHandler?) -> ActionSheet {
        return super.addAction(title, style: style, preferredAction: false, handler: handler) as? ActionSheet ?? self
    }
    
    @discardableResult
    override func presentIn(_ source: UIViewController) -> ActionSheet { return super.presentIn(source) as? ActionSheet ?? self }
    
    @discardableResult
    func setTint(_ color: UIColor) -> ActionSheet {
        self.tintColor = color
        return self
    }
    
    @discardableResult
    func setBarButtonItme(_ item: UIBarButtonItem) -> ActionSheet {
        if let popoverContoller = self.alertController.popoverPresentationController { popoverContoller.barButtonItem = item }
        super.configuredPopoverController = true
        return self
    }
    
    @discardableResult
    func setPresentingSource(_ source: UIView) -> ActionSheet {
        if let popoverController = self.alertController.popoverPresentationController {
            popoverController.sourceView = source
            popoverController.sourceRect = source.bounds
        }
        super.configuredPopoverController = true
        return self
    }
}
