//
//  ViewController.swift
//  toDoList
//
//  Created by shuhui chen on 2022-05-25.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var tasks: UITableView!
	
	@IBAction func addTap(){
		let vc = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
		vc.title = "New Task"
		vc.update = {
			DispatchQueue.main.async {
				self.updateTasks()
			}
		}
		navigationController?.pushViewController(vc, animated: true)
	}
	
	var tasksContent = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		tasks.delegate = self
		tasks.dataSource = self
		
		//set up
		if !UserDefaults().bool(forKey: "setup") {
			UserDefaults().set(true, forKey: "setup")
			UserDefaults().set(0, forKey: "count")
		}
		updateTasks()
	}
	
	func updateTasks(){
		tasksContent.removeAll()
		//get count of tasks
		guard let count = UserDefaults().value(forKey:"count") as? Int else{
			return
		}
	
		for i in 0..<count  {
			if let task = UserDefaults().value(forKey: "task\(i+1)") as? String {
				tasksContent.append(task)
			}
		}
		tasks.reloadData()
	}
	
}
extension ViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		//select row
		let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
		vc.title = "task\(indexPath.row)"
		vc.task = UserDefaults().value(forKey: "task\(indexPath.row + 1)") as? String
		navigationController?.pushViewController(vc, animated: true)
		
	}
}

extension ViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tasksContent.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//D-queing cells
		let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
		cell.textLabel?.text = tasksContent[indexPath.row]
		return cell
	}
}
