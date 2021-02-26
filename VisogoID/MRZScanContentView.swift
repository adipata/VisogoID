//
//  ContentView.swift
//  VisogoID
//
//  Created by Adrian on 19/01/2021.
//

import SwiftUI
import NFCPassportReader

struct MRZScanContentView: View {
    @EnvironmentObject var documentData:DocumentData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var sc=MRZScanController()
    let passportReader = PassportReader()
    @State var msgText="Read passport"

    var btnBack : some View { Button(action: {
        sc.stop()
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image(systemName: "arrowshape.turn.up.left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                Text("Back")
                    .foregroundColor(.white)
            }
        }
    }
    
    var body: some View {
        VStack{
            if (documentData.status=="b") {
                VStack{
                    Text("Hello Mr. "+documentData.name!)
                    Image(uiImage: documentData.facialImage!)

                    Button(action:{
                        passportReader.readPassport(mrzKey: "052961998782010432005146", tags: [.COM, .DG1, .DG2, .DG14, .SOD], customDisplayMessage: { (displayMessage) in
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
                                //DispatchQueue.main.async {
                                documentData.passportImage=passport.passportImage
                                documentData.status="c"
                                //}
                            } else {
                                print("Error: ", error.debugDescription)
                            }
                        })
                    }){
                        Text("Read")
                    }.buttonStyle(NeumorphicButtonStyle(bgColor: .red))
                }
            } else if (documentData.status=="a") {
                sc
                Button(action:{
                    sc.start()
                }){
                    Text("Scan MRZ")
                }.buttonStyle(NeumorphicButtonStyle(bgColor: .green))
            } else if (documentData.status=="c") {
                Text("Document number: "+msgText)
                Image(uiImage:documentData.passportImage!)
            }
            Spacer()
        }.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    }
    
    func handleProgress(percentualProgress: Int) -> String {
        let p = (percentualProgress/20)
        let full = String(repeating: "🟢 ", count: p)
        let empty = String(repeating: "⚪️ ", count: 5-p)
        return "\(full)\(empty)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MRZScanContentView()
    }
}

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .shadow(color: .white, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? -5: -15, y: configuration.isPressed ? -5: -15)
                        .shadow(color: .black, radius: configuration.isPressed ? 7: 10, x: configuration.isPressed ? 5: 15, y: configuration.isPressed ? 5: 15)
                        .blendMode(.overlay)
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(bgColor)
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}
