//
//  RoundView.swift
//  Chats
//
//  Created by gabatx on 13/2/23.
//

import Foundation
import UIKit


class RoundView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
