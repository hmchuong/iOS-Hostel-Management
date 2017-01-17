//
//  RoomTableViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit

class RoomTableViewController: UITableViewController,UINavigationControllerDelegate {
    
    var nhatro: NhaTro? = nil
    var phongtros: [Phong]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.editButtonItem.title = "Xoá"
        self.editButtonItem.tintColor = UIColor.white
        navigationItem.rightBarButtonItems?.append(editButtonItem)
        navigationController?.navigationBar.tintColor = UIColor.white
        loadPhongTros()
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

    // MARK: - Private methods
    private func loadPhongTros(){
        let phongtro1 = Phong(maphong: "1",ten: "1", dientich: 35, giaphong: 3500000, tinhtrang: .trong)
        let phongtro2 = Phong(maphong: "2", ten: "2", dientich: 45, giaphong: 4500000, tinhtrang: .daThue)
        let phongtro3 = Phong(maphong: "3", ten: "3", dientich: 40, giaphong: 4000000, tinhtrang: .suaChua)
        phongtros = [phongtro1, phongtro2, phongtro3]
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phongtros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RoomTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RoomTableViewCell else{
            fatalError("The dequeued cell is not an instance of  RoomTableViewCell")
        }
        
        let phongtro = phongtros[indexPath.row]
        
        cell.roomName.text = "Phòng \(phongtro.maPhong)"
        cell.roomArea.text = "Diện tích: \(phongtro.dienTich) m2"
        cell.roomPrice.text = "Giá: \(phongtro.giaPhong) đồng"
        cell.roomState.text = "Tình trạng: \(phongtro.tinhTrang.rawValue)"
        if phongtro.hinhAnhMinhHoa.count > 0{
            cell.detailImage.image = phongtro.hinhAnhMinhHoa[0]
            cell.detailImage.contentMode = UIViewContentMode.scaleAspectFit
        }
        
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
            phongtros.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
