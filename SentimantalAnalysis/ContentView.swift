//
//  ContentView.swift
//  SentimantalAnalysis
//
//  Created by shehan karunarathna on 2022-02-25.
//

import SwiftUI
import NaturalLanguage

struct ContentView: View {
    @State var textInput:String = ""
    let tagger = NLTagger(tagSchemes: [.sentimentScore])
    func sentimantalAnalysis(text:String) -> String{
        tagger.string = text
       let (sentimentscore,_) =  tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        var textpredict  = ""
        var score:Double = 0
        if let val = Double(sentimentscore?.rawValue ?? ""){
            score = val
        } else{
            score = 0
        }
        
       
        if score > 0.5 {
            textpredict = "happy"
            } else if score >= 0 {
                textpredict = "positive"
            } else if score > -0.5 {
                textpredict = "worried"
            } else {
                textpredict = "crying"
            }
        return textpredict
    }
    var body: some View {
        VStack{
            Text("Sentimantal analysis")
            TextField("",text: $textInput)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10).stroke(.black)
                )
            Text(sentimantalAnalysis(text: textInput))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
