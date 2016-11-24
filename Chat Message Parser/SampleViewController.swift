//
//  ViewController.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController, UITextFieldDelegate {
    
    enum TextFieldState {
        case Empty
        case Typing
        case Done
    }
    
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var textField: UITextField!
    
    private var textFieldState: TextFieldState = .Empty {
        didSet {
            configureTextFieldState(state: textFieldState)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
    
    private func configureTextField() {
        textField.delegate = self
        textFieldState = .Empty
    }
    
    private func configureTextFieldState(state: TextFieldState) {
        switch (state) {
        case .Empty:
            textView.text = ""
        case .Typing:
            textView.text = ""
        case .Done:
            if let textFieldText = textField.text {
                textView.text = ChatMessage(textFieldText   ).parse([.Mentions, .Emoticons, .Links])
            }
        }
    }

    // MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldState = .Typing
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textFieldState = .Typing
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textFieldState = .Empty
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldState = .Done
        return true
    }

}

