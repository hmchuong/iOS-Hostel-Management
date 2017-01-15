//
//  HostelTableViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/12/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit

class HostelTableViewController: UITableViewController {
    // MARK: - Properties
    var nhatros = [NhaTro]()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.editButtonItem.title = "Xoá"
        navigationItem.leftBarButtonItem = editButtonItem
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        loadNhatros()
    }
    
    override func setEditing (_ editing:Bool, animated:Bool)
    {
        super.setEditing(editing,animated:animated)
        if self.isEditing{
            self.editButtonItem.title = "Xong"
        }else{
            self.editButtonItem.title = "Xoá"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? EditHostelViewController, let nhatro = sourceViewController.nhatro {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing hostel.
                if ChuNha.getInstance().updateNhaTro(old: nhatros[selectedIndexPath.row], new: nhatro){
                    ChuNha.getInstance().nhatros?[selectedIndexPath.row] = nhatro
                    nhatros[selectedIndexPath.row] = nhatro
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            }else{
                let newIndexPath = IndexPath(row: nhatros.count, section: 0)
                if ChuNha.getInstance().addNhaTro(nhatro){
                    ChuNha.getInstance().nhatros?.append(nhatro)
                    nhatros.append(nhatro)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }else{
                    print("Cannot insert to database")
                }
            }
        }
        
    }
    
    // MARK: - Private methods
    private func loadNhatros(){
        nhatros = ChuNha.getInstance().nhatros ?? []
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nhatros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "HostelTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HostelTableViewCell else{
            fatalError("The dequeued cell is not an instance of  NhaTroTableViewCell")
        }
        
        let nhatro = nhatros[indexPath.row]
        
        cell.hostelIDLabel.text = nhatro.ten
        cell.hostelAddressLabel.text = nhatro.diachi

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if ChuNha.getInstance().deleteNhaTro(nhatros[indexPath.row]){
                nhatros.remove(at: indexPath.row)
                ChuNha.getInstance().nhatros?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }else{
                print("Cannot delete NhaTro")
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
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddHostel":
            print("Adding a new hostel.")
            
        case "ShowDetail":
            guard let hostelDetailViewController = segue.destination as? EditHostelViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedHostelCell = sender as? HostelTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedHostelCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedHostel = nhatros[indexPath.row]
            hostelDetailViewController.nhatro = selectedHostel
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    

}
