//
//  AddVC.swift
//  LabAssignment2
//
//  Created by Sandeep Jangra on 2020-01-21.
//  Copyright © 2020 Sandeep. All rights reserved.
//

import UIKit
import CoreData
class AddVC: UIViewController {

    @IBOutlet var textfields : [UITextField]!

           
           var tasks : [Task]?
           weak var delegate : TaskTableViewController?
           
           override func viewDidLoad() {
               super.viewDidLoad()
      
               
               SaveCoreData()

      
               NotificationCenter.default.addObserver(self, selector: #selector(SaveCoreData), name: UIApplication.willResignActiveNotification, object: nil)
               
           }
    
    
    override func viewWillDisappear(_ animated: Bool) {
                   
               delegate?.updateArray(taskArray: tasks!)
               
         
               }
    
    
    
    @IBAction func addTask(_ sender: UIButton) {
              let title1 = textfields[0].text ?? ""
              let days1 = Int(textfields[1].text ?? "0") ?? 0
                         
                      
              let task = Task(title: title1, days: days1)
              tasks?.append(task)
              
                         for textField in textfields {
                              textField.text = ""
                             textField.resignFirstResponder()
                         }
              
              
                     }
    
    @objc func SaveCoreData(){
             
                   clearCoreData()
               
               let appDelegate = UIApplication.shared.delegate as! AppDelegate

               
               let ManagedContext = appDelegate.persistentContainer.viewContext

               for task in tasks!{
                   let taskEntity = NSEntityDescription.insertNewObject(forEntityName: "TaskModel", into: ManagedContext)
                  taskEntity.setValue(task.title, forKey: "title")
                  taskEntity.setValue(task.days, forKey: "days")


                   
                   do{
                       try ManagedContext.save()
                   }catch{
                       print(error)
                   }

               }
                LoadCoreData()
           }

    func clearCoreData(){
     
     let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
     let ManagedContext = appDelegate.persistentContainer.viewContext

        
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")

        fetchRequest.returnsObjectsAsFaults = false
        do{

            let results = try ManagedContext.fetch(fetchRequest)
            for managedObjects in results{
                if let managedObjectsData = managedObjects as? NSManagedObject{

                    ManagedContext.delete(managedObjectsData)
                }
            }
        }
            catch{
                print(error)
            }

    }
    
    
    func LoadCoreData(){

               tasks = [Task]()
               
                      let appDelegate = UIApplication.shared.delegate as! AppDelegate

                      
                      let ManagedContext = appDelegate.persistentContainer.viewContext

               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")

               do{
                   let results = try ManagedContext.fetch(fetchRequest)
                   if results is [NSManagedObject]{
                       for result in results as! [NSManagedObject]{
                           let title = result.value(forKey:"title") as! String

                           let days = result.value(forKey: "days") as! Int


                           tasks?.append(Task(title: title, days: days))

                       }
                   }
               } catch{
                   print(error)
               }
               
             
           }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
