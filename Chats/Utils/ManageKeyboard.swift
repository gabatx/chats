//
//  KeyboardGestion.swift
//  Chats
//
//  Created by gabatx on 14/2/23.
//

import Foundation
import UIKit


class ManageKeyboard:NSObject {

    var view: UIView
    var navBottomBackground: UIView
    var keyboardSize: CGFloat?

    init(view: UIView, navBottomBackground: UIView) {
        self.view = view
        self.navBottomBackground = navBottomBackground
    }

    func addObserverKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hiddenKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func deletedObserverKeyboard(){
        // Eliminar observadores
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    func hidesKeyboardWhenClickingOutside(view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func showKeyboard(notification: NSNotification) {
        resizeConstraintHeight(size: 50, position: 5)

        // Le estamos diciendo que intente definir una constante con Notificacition(el objeto que ha llegado como parámetro) con el tamaño del teclado
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Si el campo seleccionado está por debajo del teclado, entonces se va a desplazar la pantalla hacia arriba
            if view.frame.origin.y == 0 {
                // Cambiarle alto a navBottomBackground a la mitad
                view.frame.origin.y -= keyboardSize.height
                self.keyboardSize = keyboardSize.height
            }
        }
    }

    @objc func hiddenKeyboard(notification: NSNotification) {
        resizeConstraintHeight(size: 100, position: 5)
        // Le estamos diciendo que vuelva a su sitio de origen
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    private func resizeConstraintHeight(size: CGFloat, position: Int) {
        // Hacerlo con animación
        UIView.animate(withDuration: 0.5) { [self] in
            navBottomBackground.constraints[position].constant = size
            view.layoutIfNeeded()
        }
    }
}
