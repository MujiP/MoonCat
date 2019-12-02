//
//  Displaying.swift
//
//  Created by Muji Paracha on 2019-10-27.
//  Copyright © 2019 Muji Paracha. All rights reserved.
//

import Foundation
import PromiseKit

/** Adopting VC's acquire the ability to display events.
 The protocol takes care of displaying a loader, making the request to get some events,
 and then showing them in an Events_TVC, stopping the loader when done.
 */

protocol Displaying: UIViewController {
    var request: Promise<[Event]> { get }
    var loader: CircularLoader! { get set }
    var vc: Events_TVC? { get set }
}

extension Displaying {

    
    func setup() {
        let c = CircularLoader(color: #colorLiteral(red: 0.2200894952, green: 0.4641377926, blue: 0.8669697642, alpha: 1))
        self.view.addSubview(c)
        c.center = self.view.midPoint
        self.loader = c
        c.hide()
        
    }
    
    func go() {
        self.setup()
        self.loader.show()
        self.loader.start()
        
        
        //        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
        //
        //            let vc = Events_TVC()
        //            self.welcomeChild(vc) { (v) in
        //                v.frame = self.view.bounds
        //                self.view.insertSubview(v, at: 0)
        //            }
        //
        //            self.loader.stop {
        //                self.loader.removeFromSuperview()
        //                self.loader = nil
        //            }
        //
        //            vc.intro()
        //            self.vc = vc
        //        }
        
        
        firstly {
            self.request
        }.done { events in
            print("Received \(events.count) events")
            
            guard events.count > 0 else {
                return
            }
            
            let vc = Events_TVC(events: events)
            self.welcomeChild(vc) { (v) in
                v.frame = self.view.bounds
                self.view.insertSubview(v, at: 0)
            }
            
            vc.intro()
            self.vc = vc
            
        }.ensure {
            self.loader.stop {
                self.loader.removeFromSuperview()
                self.loader = nil
            }
        }.catch { error in
            print(error)
        }
        
        
    }
    
    func refresh() {
        self.vc?.leave()
        self.go()
    }
    
}
