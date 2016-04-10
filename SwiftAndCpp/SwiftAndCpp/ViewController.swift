//
//  ViewController.swift
//  SwiftAndCpp
//
//  Created by Nestor Javier Hernandez Bautista on 4/9/16.
//  Copyright © 2016 Nestor Javier Hernandez Bautista. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        
        let l = getEmptyList()
        insertAtBack(l, 10)
        insertAtBack(l, 11)
        insertAtBack(l, 12)
        printList(l)
        
        super.viewDidLoad()    
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


}

