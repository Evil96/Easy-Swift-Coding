//
//  ViewController.swift
//  TablaSencilla
//
//  Created by Edgar Vilchis on 12/05/17.
//  Copyright © 2017 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkeerestaurant", "posatelier", "bourkestreetbakery", "haighschocolate", "palominoespresso", "upstate", "traif", "grahamavenuemeats", "wafflewolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "caskpubkitchen"]
    
    var restaurantVisited = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false,false, false, false, false, false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.imageView?.image =  UIImage(named: restaurantImages[indexPath.row])
        
        if restaurantVisited[indexPath.row]{
            cell.accessoryType = .checkmark
        } else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title:nil, message:"¿Desea reservar?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title:"No", style:.cancel, handler: {
            (UIAlertAction) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            self.restaurantVisited[indexPath.row] = false
        })
        
        let okAction = UIAlertAction(title:"Si", style:.default, handler: {
            (UIAlertAction) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.restaurantVisited[indexPath.row] = true
            
        })
        
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(okAction)
        
            present(optionMenu, animated: true, completion: nil)
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            restaurantNames.remove(at: indexPath.row)
//            restaurantImages.remove(at: indexPath.row)
//            restaurantVisited.remove(at: indexPath.row)
//        }
//
//        tableView.deleteRows(at: [indexPath], with: .fade)
//
//        //tableView.reloadData()
//    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Borrar"){(action, sourceview, completionHandler) in
                self.restaurantNames.remove(at: indexPath.row)
                self.restaurantVisited.remove(at: indexPath.row)
                self.restaurantImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title:"Compartir"){ (action, sourceview, completionHandler) in
            
            let texto = "Reservando en " + self.restaurantNames[indexPath.row]
            
            let activityController:UIActivityViewController
            
            if let imagen = UIImage(named: self.restaurantImages[indexPath.row]){
                activityController = UIActivityViewController(activityItems: [texto, imagen], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }else{
               activityController = UIActivityViewController(activityItems: [texto], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
            
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        
        return swipeConfiguration
    }
}

