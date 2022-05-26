//
//  TaskViewController.swift
//  toDoList
//
//  Created by shuhui chen on 2022-05-25.
//

import UIKit

class TaskViewController: UIViewController {
	
	@IBOutlet weak var label: UILabel!
	var task: String!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		label.text = task
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete", style: .done, target: self, action: #selector(deleteTask))

        // Do any additional setup after loading the view.
    }
	
	@objc func deleteTask(){
		
	}
    

  
}
