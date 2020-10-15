//
//  ViewController.swift
//  KeychainValet
//
//  Created by Alex Nagy on 15/10/2020.
//

import UIKit
import Valet

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // keys
        let key = "Rebeloper"
        let dataKey = "RebeloperData"
        
        // Indentifiers
        let identifier = Identifier(nonEmpty: "Druida")!
        let sharedGroupIdentifierWithAppIDPrefix = SharedGroupIdentifier(appIDPrefix: "AppID12345", nonEmptyGroup: "com.rebeloper.KeychainValet.SharedItems")!
        let sharedGroupIdentifierWithGroupPrefix = SharedGroupIdentifier(groupPrefix: "group", nonEmptyGroup: "com.rebeloper.KeychainValet")!
        
        // Basic Init
        let myValet = Valet.valet(with: identifier, accessibility: .whenUnlocked)
        
        // Shared valet - app ID prefix
        let sharedValet = Valet.sharedGroupValet(with: sharedGroupIdentifierWithAppIDPrefix, accessibility: .whenUnlocked)
        
        let sharedValet2 = Valet.sharedGroupValet(with: sharedGroupIdentifierWithGroupPrefix, accessibility: .whenUnlocked)
        
        // iCloud sharing
        
        let cloudValet = Valet.iCloudValet(with: identifier, accessibility: .whenUnlocked)
        
        let sharedCloudValet = Valet.iCloudSharedGroupValet(with: sharedGroupIdentifierWithAppIDPrefix, accessibility: .whenUnlocked)
        
        let sharedCloudValet2 = Valet.iCloudSharedGroupValet(with: sharedGroupIdentifierWithGroupPrefix, accessibility: .whenUnlocked)
        
        // enclave
        let mySecureEnclaveValet = SecureEnclaveValet.valet(with: identifier, accessControl: .userPresence)
        
        let mySecureEnclaveValet2 = SinglePromptSecureEnclaveValet.valet(with: identifier, accessControl: .userPresence)
        
        // migration
        let myOldValet = Valet.valet(with: identifier, accessibility: .whenUnlocked)
        let myNewValet = Valet.valet(with: identifier, accessibility: .afterFirstUnlock)
        try? myNewValet.migrateObjects(from: myOldValet, removeOnCompletion: true)
        
        // access
        print("can access keychain: \(myNewValet.canAccessKeychain())")
        
        // writing
        try? myNewValet.setString("12345", forKey: key)
        try? myNewValet.setObject("abcd".data(using: .utf8)!, forKey: dataKey)
        
        // contains object
        print("contains object '\(key)': \(String(describing: try? myNewValet.containsObject(forKey: key)))")
        
        // reading
        let myValue = try? myNewValet.string(forKey: key)
        print("my value: \(String(describing: myValue))")
        
        let myDataValue = try? myNewValet.object(forKey: dataKey)
        print("my data value: \(String(describing: String(data: myDataValue!, encoding: .utf8)))")
        
        // all keys
        print("all keys: \(String(describing: try? myNewValet.allKeys()))")
        
        try? myNewValet.removeObject(forKey: key)
        let myNewValue = try? myNewValet.string(forKey: key)
        print("my new value: \(String(describing: myNewValue))")
        
        try? myNewValet.setString("12345", forKey: key)
        try? myNewValet.removeAllObjects()
        let myNewValue2 = try? myNewValet.string(forKey: key)
        print("my new value2: \(String(describing: myNewValue2))")
        
    }


}

