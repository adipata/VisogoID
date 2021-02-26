//
//  DocumentData.swift
//  VisogoID
//
//  Created by Adrian on 03/02/2021.
//

import Foundation
import UIKit
import NFCPassportReader

class DocumentData:ObservableObject{
    @Published var status="a"
    var name:String?
    var facialImage:UIImage?
    var passportImage:UIImage?
    var certSubject:String?
}
