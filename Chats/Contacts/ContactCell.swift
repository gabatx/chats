//
//  ContactCell.swift
//  Chats
//
//  Created by gabatx on 13/2/23.
//

import UIKit

class ContactCell: UITableViewCell {


    @IBOutlet weak var contactInitials: UILabel!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactDateLastMessage: UILabel!
    @IBOutlet weak var contactInitialsBackground: RoundView!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }


    func configure(contact: User){

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        let initials = "\(contact.name.first!)\(contact.surname.first!)"

        contactInitials.text = initials
        contactName.text = "\(contact.name) \(contact.surname)"
        contactDateLastMessage.text = dateFormatter.string(from: contact.lastLoginDate)
        contactInitialsBackground.backgroundColor = generatorRandomColor()
    }

    func generatorRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
