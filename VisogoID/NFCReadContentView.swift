//
//  NFCReadContentView.swift
//  VisogoID
//
//  Created by Adrian on 01/02/2021.
//

import SwiftUI
import NFCPassportReader

struct NFCReadContentView: View {
    let passportReader = PassportReader()
    @State var msgText="Read passport"
    
    var body: some View {
        Text(msgText)
        Button(action:{
            passportReader.readPassport(mrzKey: "052961998782010432005146", tags: [.COM, .DG1, .SOD], customDisplayMessage: { (displayMessage) in
                switch displayMessage {
                    case .requestPresentPassport:
                        return "Hold your iPhone near an NFC enabled ID Card / Passport."
                    case .successfulRead:
                        return "ID Card / Passport Read Succesfully."
                    case .readingDataGroupProgress(let dataGroup, let progress):
                        let progressString = self.handleProgress(percentualProgress: progress)
                        return "Reading Data \(dataGroup) ...\n\(progressString)"
                    default:
                        return nil
                }
            }, completed: { (passport, error) in
                if let passport = passport {
                    //print(passport.documentNumber)
                    msgText=passport.documentNumber
                    
                } else {
                    print("Error: ", error.debugDescription)
                }
            })
        }){
            Text("Read")
        }.buttonStyle(NeumorphicButtonStyle(bgColor: .gray))
    }
    
    func handleProgress(percentualProgress: Int) -> String {
        let p = (percentualProgress/20)
        let full = String(repeating: "🟢 ", count: p)
        let empty = String(repeating: "⚪️ ", count: 5-p)
        return "\(full)\(empty)"
    }
}

struct NFCReadContentView_Previews: PreviewProvider {
    static var previews: some View {
        NFCReadContentView()
    }
}
