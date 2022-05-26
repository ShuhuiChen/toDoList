//
//  EntryViewController.swift
//  toDoList
//
//  Created by shuhui chen on 2022-05-25.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet  var textfield: UITextField!
	var update: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
		textfield.delegate = self
        // Do any additional setup after loading the view.
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveTask))
    }
    
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		saveTask()
		return true
	}
	
	@objc func saveTask(){
		//make sure the textfiled is not empty
		guard let text = textfield.text, !text.isEmpty else {
			return
		}
		//count ++
		guard let count = UserDefaults().value(forKey: "count") as? Int else {
			return
		}
		let newCount = count + 1
		//save new count and new task content
		UserDefaults().set(newCount, forKey: "count")
		UserDefaults().set(text, forKey: "task\(newCount)")
		
		update?()
		
		//pop back to root view controller
		navigationController?.popViewController(animated: true)
	}

   

}
