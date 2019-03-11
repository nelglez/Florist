//
//  RomanceApi.swift
//  Florist
//
//  Created by Nelson Gonzalez on 3/11/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RomanceApi {
    var REF_ROMANCE = Database.database().reference().child("romance")
    
    func observeRomance(withCategoryId id: String, completion: @escaping (Romance)-> Void){
        REF_ROMANCE.child(id).observe(.value) { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let newRomance = Romance.transformRomance(dict: dict, key: snapshot.key)
                completion(newRomance)
            }
            
        }
        
    }
    
    func observeSingleRestaurant(completion: @escaping (Romance) -> Void){
        REF_ROMANCE.observe(.childAdded) { (snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let newRomance = Romance.transformRomance(dict: dict, key: snapshot.key)
                
                completion(newRomance)
                
            }
        }
    }
    
}
