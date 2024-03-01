//
//  KeyboardViewController.swift
//  mycustomKeyboard
//
//  Created by promact on 23/02/24.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet weak var firstScreen: UIStackView!
    @IBOutlet weak var secondScreen: UIStackView!
    @IBOutlet weak var thirdScreen: UIStackView!
    
    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBOutlet var alphabets: [UIButton]!
    
    @IBOutlet weak var backspace: UIButton!
    
    @IBOutlet weak var newline: UIButton!
    
    @IBOutlet weak var spacebar: UIButton!
    
    @IBOutlet weak var capsLock: UIButton!
    
    // Define a boolean variable to track the state of caps lock
    var capsLockEnabled = false
    @IBOutlet var numericandsymbols: [UIButton]!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    
    
    
}

extension KeyboardViewController{
    //for any alphabet clicked the below function is executed
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let key = sender.titleLabel?.text else {return}
        (textDocumentProxy as UIKeyInput).insertText(key)
    }
    
    //for backspace click below function is executed
    @IBAction func backspaceTapped(){
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    //for newlinw button click below function is executed
    @IBAction func newlineTapped(){
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    //for spacebar click below function is executed
    @IBAction func spacebarTapped(){
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    //for @ click below function is executed
    @IBAction func attherateTapped(_ sender: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("@")
    }

    // Function to toggle caps lock state and update buttons accordingly
    func toggleCapsLockState(for buttons: [UIButton]) {
        capsLockEnabled.toggle()
        
        for button in buttons {
            let currentTitle = button.titleLabel?.text ?? ""
            let updatedTitle = capsLockEnabled ? currentTitle.uppercased() : currentTitle.lowercased()
            button.setTitle(updatedTitle, for: .normal)
        }
    }
    
    //for capslock click this function will be called
    @IBAction func capsLockTapped(){
        toggleCapsLockState(for: alphabets)
    }
    
    //for close keyboard button click this function will be executed
    @IBAction func closeKeyboardTapped(_ sender: UIButton) {
        dismissKeyboard()
    }
    
    //for buttons having two symbols this function will be executed
    @IBAction func twoItemButtonsTapped(_ sender: UIButton){
        if(capsLockEnabled){
            guard let key = sender.titleLabel?.text else {return}
            (textDocumentProxy as UIKeyInput).insertText(key)
        }else{
            guard let key = sender.subtitleLabel?.text else {return}
            (textDocumentProxy as UIKeyInput).insertText(key)
        }
    }
    
    @IBAction func showNumericKeyboardTapped(_ sender: UIButton) {
        self.firstScreen.alpha = 0
        self.secondScreen.alpha = 1
        self.thirdScreen.alpha = 0
    }
    
    @IBAction func showAlphabeticKeyboardTapped(_ sender: UIButton) {
        self.secondScreen.alpha = 0
        self.firstScreen.alpha = 1
        self.thirdScreen.alpha = 0
    }
    
    @IBAction func showThirdscreen(_ sender: UIButton) {
        self.secondScreen.alpha = 0
        self.firstScreen.alpha = 0
        self.thirdScreen.alpha = 1
    }
    
    @IBAction func shiftLeft(){
        (textDocumentProxy as UITextDocumentProxy).adjustTextPosition(byCharacterOffset: -1)
    }
}
