//
//  ProfissionalTableTableViewController.swift
//  GS_IOS_Edu_Osvaldo
//
//  Created by Eduardo  Souza on 16/11/25.
//

import UIKit
import CoreData

class ProfissionalTableTableViewController: UITableViewController {
    
    
    var profissional: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Profissional")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nome", ascending: true)]
        do{
            profissional = try managedContext.fetch(fetchRequest)
        }catch let error as NSError{
            print("Não foi possível gravar \(error) \(error.userInfo)")
        }
        self.tableView.reloadData()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profissional.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        var profissional = profissional[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = profissional.value(forKey: "nome") as? String
        cell.detailTextLabel?.text = profissional.value(forKey: "profissao") as? String
        
        return cell
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedContext = appDelegate.persistentContainer.viewContext
            
            managedContext.delete(profissional[indexPath.row])
            
            do{
                try managedContext.save()
                profissional.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }catch let error as NSError{
                print("Não foi possível gravar \(error) \(error.userInfo)")
            }
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableParaAlterarSegue"{
            let vc = segue.destination as! ProfissionalViewController
            let profissionalSelecionada:NSManagedObject = profissional[self.tableView.indexPathForSelectedRow!.item]
            vc.profissionalVindoDaTable = profissionalSelecionada
        }
        
    }
    
}
    
