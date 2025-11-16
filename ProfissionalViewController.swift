//
//  ProfissionalViewController.swift
//  GS_IOS_Edu_Osvaldo
//
//  Created by Eduardo  Souza on 16/11/25.
//

import UIKit
import CoreData


class ProfissionalViewController: UIViewController {
    
    var profissionalVindoDaTable:NSManagedObject?=nil
    
    
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtProfissao: UITextField!
    @IBOutlet weak var txtCargo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if profissionalVindoDaTable != nil{
            txtNome.text = profissionalVindoDaTable?.value(forKey: "nome") as? String
            txtEmail.text = profissionalVindoDaTable?.value(forKey: "email") as? String
            txtTelefone.text = profissionalVindoDaTable?.value(forKey: "telefone") as? String
            txtProfissao.text = profissionalVindoDaTable?.value(forKey: "profissao") as? String
            txtCargo.text = profissionalVindoDaTable?.value(forKey: "cargo") as? String
        }
    }
    
    
    @IBAction func salvar(_ sender: Any) {
        self.save(nome: txtNome.text!, telefone: txtTelefone.text!, email: txtEmail.text!, profissao: txtProfissao.text!, cargo: txtCargo.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func save(nome:String, telefone:String, email:String, profissao:String, cargo:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entidade = NSEntityDescription.entity(forEntityName: "Profissional", in: managedContext)!
        
        if profissionalVindoDaTable == nil{
            //inicio do processo de gravação
            let pessoa = NSManagedObject(entity: entidade, insertInto: managedContext)
            pessoa.setValue(nome, forKey: "nome")
            pessoa.setValue(telefone, forKey: "telefone")
            pessoa.setValue(email, forKey: "email")
            pessoa.setValue(profissao, forKey: "profissao")
            pessoa.setValue(cargo, forKey: "cargo")
        }else{
            let objectUpdate = profissionalVindoDaTable
            objectUpdate!.setValue(nome, forKey: "nome")
            objectUpdate!.setValue(telefone, forKey: "telefone")
            objectUpdate!.setValue(email, forKey: "email")
            objectUpdate!.setValue(profissao, forKey: "profissao")
            objectUpdate!.setValue(cargo, forKey: "cargo")
        }
        
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Não foi possível gravar \(error) \(error.userInfo)")
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
