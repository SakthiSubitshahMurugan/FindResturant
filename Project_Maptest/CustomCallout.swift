//
//  CustomCallout.swift
//  Project_Maptest
//
//  Created by Sakhti Subitshah Murugan on 9/7/17.
//  Copyright © 2017 Sakhti Subitshah Murugan. All rights reserved.
//

import UIKit
import MapKit

class CustomCallout: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: "pin")
        self.canShowCallout=true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
