//
//  CustomTextField.swift
//  FaceMemoApp
//
//  Created by Vusal Nuriyev 2 on 19.06.24.
//

import SwiftUI

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.isEditable = true
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.adjustsFontForContentSizeCategory = true
        textView.returnKeyType = .done
        textView.textColor = .white
        textView.text = text
        return textView
    }
    func updateUIView(_ uiView: UITextView, context: Context) {
        if !isEditing {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, doneEditing: $isEditing)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        @Binding var isEditing: Bool
        
        init(text: Binding<String>, doneEditing: Binding<Bool>) {
            _text = text
            _isEditing = doneEditing
        }
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
        }
        
        func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
            textView.resignFirstResponder()
            return !isEditing
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            isEditing = true
        }
    }
}

