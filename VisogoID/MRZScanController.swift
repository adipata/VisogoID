//
//  ScanController.swift
//  VisogoID
//
//  Created by Adrian on 20/01/2021.
//

import SwiftUI
import QKMRZScanner

struct MRZScanController: UIViewRepresentable {
    @EnvironmentObject var documentData:DocumentData
    let scn=QKMRZScannerView()
    @ObservedObject var vc=MRZScannerViewController()

    func makeUIView(context: Context) -> QKMRZScannerView{
        return scn;
    }
    
    func updateUIView(_ uiViewController:QKMRZScannerView, context: Context){
        print("**** update view")
        if(!(vc.result==nil)){
            documentData.status="b"
            documentData.name=vc.result?.surnames
            documentData.facialImage=vc.result?.faceImage
            vc.result=nil
        }
    }
        
    public func start(){
        scn.delegate=vc
        scn.startScanning()
    }
    
    public func stop(){
        scn.stopScanning()
    }
}

class MRZScannerViewController: QKMRZScannerViewDelegate,ObservableObject {
    @Published var result:QKMRZScanResult?
    
    func mrzScannerView(_ mrzScannerView: QKMRZScannerView, didFind scanResult: QKMRZScanResult) {
        print("--- Rezult ---")
        print(scanResult.givenNames)
        result=scanResult
    }
}
