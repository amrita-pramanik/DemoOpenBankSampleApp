//
//  MarvelCharacterDetailsVC.swift
//  OpenBankSampleProj
//
//  Created by Amrita on 02/02/22.
//

import UIKit

class MarvelCharacterDetailsVC: UIViewController {
    
    @IBOutlet weak var lblNavBarTitle: UILabel!
    @IBOutlet weak var imgVwDetails: UIImageView!
    @IBOutlet weak var descDetails: UILabel!
    @IBOutlet weak var nameDetails: UILabel!
    
    var prevImgUrlStr : String = ""
    var prevName : String = ""
    var prevDesc : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.nameDetails.text = self.prevName
            self.descDetails.text = self.prevDesc
            
            let url = URL(string: self.prevImgUrlStr)!
            self.getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                // always update the UI from the main thread
                DispatchQueue.main.async() {
                    self.imgVwDetails.image = UIImage(data: data)
                }
            }
            
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
