//
//  MainContentView.swift
//  VisogoID
//
//  Created by Adrian on 01/02/2021.
//

import SwiftUI

struct MainContentView: View {
    var id=true
    let userDefaults:UserDefaults
    @State var msg="Welcome"
    @State var idCreated:Bool=UserDefaults.standard.bool(forKey: "hasId")
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    var body: some View {
        NavigationView{
            VStack{
            if idCreated {
                Image("bar")
                    .resizable()
                    .scaledToFit()
                    .padding(50)
                    .shadow(color: .gray, radius: 36)
            } else {
                Image("launcher")
                    .resizable()
                    .scaledToFit()
                    .padding(50)
                    .shadow(color: .gray, radius: 36)
            }
            Spacer()
        
        
            NavigationLink(destination: MRZScanContentView()){
                Text("Enroll")
            }.padding()
            .background(Color.gray)
            .foregroundColor(Color.black)
            .cornerRadius(10)
            }
        }
                
        /*
        Button(action:{
            userDefaults.setValue(true, forKey: "hasId")
            idCreated=true
        }){
            Text("Create ID")
        }
        .padding(10)
        
        Button(action:{
            userDefaults.removeObject(forKey: "hasId")
            idCreated=false
        }){
            Text("Delete ID")
        }
        .padding(10)
        
        .padding(10)
        
        Text(msg)
         */
    }
    
    func hasId()->Bool{
        let id:Any?=userDefaults.value(forKey: "hasId")
        return !(id==nil)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
