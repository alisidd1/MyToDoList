//
//  tableViewCell.swift
//  ToDoList
//
//  Created by Ali Siddiqui on 1/11/24.
//

import UIKit
import CoreData

final class tableViewCell: UITableViewCell {
    static let identifier = "tableViewCell"

    let update = UIAction(title: "Save item", image: UIImage(systemName: "note.text.badge.plus")) { (action) in
        NotificationCenter.default.post(name: NSNotification.Name("update"),object: nil)
    }
    
//    lazy var textEntry: UITextView = {
//        let text = UITextView()
//        text.translatesAutoresizingMaskIntoConstraints = false
//        text.backgroundColor = .systemGray
//        text.font = UIFont.systemFont(ofSize: 15)
//        text.autocorrectionType = UITextAutocorrectionType.no
//        text.keyboardType = UIKeyboardType.default
//        text.returnKeyType = UIReturnKeyType.done
//        text.layer.borderColor = UIColor.gray.cgColor
//        text.layer.borderWidth = 1.0
//        text.layer.cornerRadius = 5.0
//        text.becomeFirstResponder()
//        text.isScrollEnabled = false
//        return text
//    }()
    
//    lazy var checkButton: UIButton = {
//        let btn = UIButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .systemPink
//        btn.setImage(UIImage(systemName: "checkmark"), for: .normal)
//        btn.tag = 1
//        return btn
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubviews(checkButton, textEntry)
//        contentView.addSubview(checkButton)
//        textEntry.delegate = self
        self.addConstraints()
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
//            checkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            checkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
//            checkButton.widthAnchor.constraint(equalToConstant: 44),
//            checkButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
//            
//            textEntry.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
//            textEntry.heightAnchor.constraint(equalToConstant: 40),
//            textEntry.leftAnchor.constraint(equalTo: checkButton.rightAnchor, constant: 0),
//            textEntry.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -44),
        ])
    }
    
    func configure(index: Int) {
        
    }
}

extension tableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { constraints in
            if constraints.firstAttribute == .height {
                constraints.constant = estimatedSize.height
            }
        }
    }
}
