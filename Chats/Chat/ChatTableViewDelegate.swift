//
//  ChatTableViewDelegate.swift
//  Chats
//
//  Created by gabatx on 16/2/23.
//

import Foundation
import UIKit

class ChatTableViewDelegate: NSObject, UITableViewDelegate {

    var didTapOnCell: ((Int) -> Void)?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapOnCell?(indexPath.row)
    }
}
