//
//  CustomTabBar.swift
//  Chats
//
//  Created by gabatx on 13/2/23.
//

import Foundation
import UIKit

class CustomTabBar: UITabBar {
    override var frame: CGRect {
        get {
            return super.frame
        }
        // modificar el tamaño de la barra de navegación
        set (newFrame) {
            var frame = newFrame
            frame.size.height = 100
            //frame.origin.y = frame.origin.y - 30 // Comienza el menú inferior a partir de 30 pixeles
            super.frame = frame
        }
    }

}
