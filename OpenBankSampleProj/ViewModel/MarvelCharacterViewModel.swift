//
//  MarvelCharacterViewModel.swift
//  OpenBankSampleProj
//
//  Created by Amrita on 01/02/22.
//

import Foundation

class MarvelCharacterViewModel : NSObject {
    
    private var apiService : NetworkApiService?
    var marvelCharacter : [MarvelCharacter]? = [] {
        didSet {
            bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    

    override init() {
        super.init()
        self.apiService =  NetworkApiService()
        callFuncToGetMarvelCharacterData()
    }
    func callFuncToGetMarvelCharacterData() {
        self.apiService?.getData { (jsonResponseData) in
            if let json = jsonResponseData {
                self.marvelCharacter = json.data.results
            }
            
        }
    }
}

