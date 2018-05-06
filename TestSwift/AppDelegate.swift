//
//  AppDelegate.swift
//  TestSwift
//
//  Created by Eduard Ovchinnikov on 21.04.2018.
//  Copyright © 2018 Эдуард Овчинников. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: - RandomeRange
        class RandomRange{
            var startNumber: Int = 0
            var endNumber: Int = 0
            init(start: Int, end: Int) {
                self.startNumber = start
                self.endNumber = end
                print("Call lazy")
            }
        }
        
        func random(from startNumber: Int, to endNumber: Int) ->Int {
            let howMuch = endNumber - startNumber
            let rand = Int(arc4random() % UInt32(howMuch + 1)) + startNumber
            return rand
        }
        
        
        

        let forCount = 12
        
        for _ in  0..<forCount {
            print(random(from: 0, to: 9))
        }

        
        class Player{
            lazy var range = RandomRange(start: 0, end: 9)
            static var stepsCount: Int = 0{
                willSet {
                    print("About to set totalSteps to \(newValue)")
                }
                didSet {
                    if stepsCount > oldValue  {
                        print("Added \(stepsCount - oldValue) steps")
                    }
                }
            }
            let livesMax: Int
            let strengthAttack: Int
            let accuracy: Int
            var livesPercent: Int {
                let lp = (lives * 100)/livesMax
                return lp
            }
            var lives: Int
            
            func attack(p: Player) {
                p.lives -= self.strengthAttack
                Player.stepsCount += 1
            }
            init(l: Int, s: Int, a: Int) {
                livesMax = l
                lives = l
                strengthAttack = s
                accuracy = a
            }
        }
        
        let player1 = Player(l: 200, s: 30, a: 50)
        let player2 = Player(l: 300, s: 15, a: 80)
        
        player1.attack(p: player2)
        player2.attack(p: player1)
        player1.attack(p: player2)
        player2.attack(p: player1)
        player1.attack(p: player2)
        
        print("Player2 have \(player2.lives) lives")
        print("Player1 have \(player1.lives) lives")
        
        print("Player2 have \(player2.livesMax) Max lives")
        print("Player1 have \(player1.livesMax) Max lives")
        
        print("Player have \(Player.stepsCount) steps")
        
        class Noob: Player{
            override var livesPercent: Int{
                return super.livesPercent + 100
            }
        }
        let Natasha = Noob(l: 300, s: 10, a: 20)
        print(Natasha.livesPercent)
        
        
        class someClass{
            var intValueDefault: Int = 0
            var intValueChange: Int
            var intValueOptional: Int?
            init(intValueChange: Int) {
                self.intValueChange = intValueChange
            }
        }
        let some = someClass(intValueChange: 3)
        //some.intValueOptional = 5
        guard let val = some.intValueOptional else {
            print("intValueOptional is nil")
            return true
        }
        print(val)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TestSwift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

