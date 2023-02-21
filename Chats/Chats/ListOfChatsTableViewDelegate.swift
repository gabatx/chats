//
//  ListOfChatsTableViewDelegate.swift
//  Chats
//
//  Created by gabatx on 20/2/23.
//

import Foundation
import UIKit

class ListOfChatsTableViewDelegate: NSObject, UITableViewDelegate {

    var didTapOnCell: ((Int) -> Void)?

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapOnCell?(indexPath.row)
    }
}
