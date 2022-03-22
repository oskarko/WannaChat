//
//  FCollectionReference.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import FirebaseFirestore
import Foundation

enum FCollectionReference: String {
    case user
    case recent
}

func firebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    Firestore.firestore().collection(collectionReference.rawValue)
}
