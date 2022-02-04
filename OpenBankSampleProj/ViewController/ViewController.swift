//
//  ViewController.swift
//  OpenBankSampleProj
//
//  Created by Amrita on 27/01/22.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var charcterViewModel : MarvelCharacterViewModel?
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblNavBarTitle: UILabel!
    var selectedImg = UIImage()
    let reuseIdentifier = "CharacterTblCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblNavBarTitle.text = "Marvel"
        tblView.dataSource = self
        tblView.delegate = self
        charcterViewModel = MarvelCharacterViewModel()
        charcterViewModel?.bindEmployeeViewModelToController  = {
            DispatchQueue.main.async {
                self.tblView.reloadData()
                print(self.charcterViewModel?.marvelCharacter?[0].fullImgPath)
            }
            
        }
        
    }
   
    
    // MARK: - UICollectionView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return charcterViewModel?.marvelCharacter?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CharacterTblViewCellTableViewCell
        
              
       
        cell.imgTitle.text = self.charcterViewModel?.marvelCharacter?[indexPath.row].name
        cell.imgDesc.text = self.charcterViewModel?.marvelCharacter?[indexPath.row].description
        
       let url = URL(string: self.charcterViewModel?.marvelCharacter?[indexPath.row].fullImgPath ?? "")!
       getData(from: url) { data, response, error in
           guard let data = data, error == nil else { return }
           print(response?.suggestedFilename ?? url.lastPathComponent)
           print("Download Finished")
           // always update the UI from the main thread
           DispatchQueue.main.async() {
               cell.imgCell.image = UIImage(data: data)
           }
       }
       return cell
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    

    // MARK: - UICollectionView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MarvelCharacterDetailsVC") as! MarvelCharacterDetailsVC
        vc.prevName = self.charcterViewModel?.marvelCharacter?[indexPath.row].name ?? ""
        vc.prevDesc = self.charcterViewModel?.marvelCharacter?[indexPath.row].description ?? ""
        vc.prevImgUrlStr = self.charcterViewModel?.marvelCharacter?[indexPath.row].fullImgPath ?? ""
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

