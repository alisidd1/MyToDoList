//
//  ViewController.swift
//  ToDoList
//
//  Created by Ali Siddiqui on 1/10/24.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var toDoModel = [String]()
    var toDoViewModel = [String]()
    var toDoDBModel = [ToDoListModel]()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(tableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.backgroundColor = .systemMint
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        addConstraints()
        title = "Your ToDo List"
        view.backgroundColor = .systemCyan

        NotificationCenter.default.addObserver(self, selector: #selector(saveTapped), name: NSNotification.Name ("update"), object: nil)
    }
    
    @objc func reload() {
        tableView.reloadData()
    }
    
    @objc func saveTapped() {
//        let vc = UpdateViewController()
//        navigationController?.pushViewController(vc, animated: true)
//        toDoModel.append(<#T##newElement: ToDoListItem##ToDoListItem#>)
    }
    
    @objc func deleteTapped() {
        let alert = UIAlertController(title: "Delete", message: "Do you want to delete the current item?", preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Delete", style: UIAlertAction.Style.default, handler: { action in
            self.deleteText()}))
        
           alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

           // show the alert
           self.present(alert, animated: true, completion: nil)
    }
    // handle actions
    func deleteText() {
        print("menu Delete action was tapped ")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 //       let model = toDoModel[indexPath.row]
        guard let cell = tableView .dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? tableViewCell else {
            return UITableViewCell()
        }
        
//        cell.textEntry.text = model.item
//        cell.configure(index: indexPath.row)
        toDoModel.append(cell.textEntry.text)
        
        createItem(name: cell.textEntry.text)
        
        cell.checkButton.addTarget(self, action: #selector(ViewController.showCheckAlert(sender:)), for: .touchUpInside)
        cell.menuButton.addTarget(self, action: #selector(menuButton(sender:)), for: .touchUpInside)
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
 }

     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
 }

    
    @objc func menuButton(sender: UIButton) {
        print("menu Action action was tapped ")
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
        ])
    }
    
    
    @objc func showCheckAlert(sender:UIButton){
       
        let alert = UIAlertController(title: nil, message: "Saved!", preferredStyle: .actionSheet)
        //        let index = sender.tag
        //        let indexPath = NSIndexPath(row: index, section: 0)
        alert.addAction(UIAlertAction(title: "Done", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
     
    
    
    // Mark: -  Database functions

    func getAllItems() {
        do {
            let item = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("error: getAllItems - getch request")
        }
    }
    
    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        do {
            try context.save()
        } catch {
            print("error: createItem - getch request")
        }
    }
    
    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("error: createItem - getch request")
        }

    }
    
    func udpateItem(item: ToDoListItem, newName: String) {
        item.name = newName
        do {
            try context.save()
        } catch {
            print("error: createItem - getch request")
        }
    }
}


// MARK:- ---> UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
          let fixedWidth = textView.frame.size.width
          textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
          let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
          var newFrame = textView.frame
          newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
          textView.frame = newFrame
    }

}

// MARK: UITextFieldDelegate <---



