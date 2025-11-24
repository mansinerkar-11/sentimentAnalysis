//
//  SplashSceen.swift
//  Review Analysis AI
//
//  Created by Mansi Nerkar on 21/11/25.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var goToHome: Bool = false
    @State private var offsetUp: CGFloat = 0
    @State private var offsetDown: CGFloat = 0
    
    @State private var opacity = 0.0
    @State private var scale: CGFloat = 0.0
    var body: some View {
        
        ZStack {
            if goToHome {
                ContentView()   // your next screen
            } else {
                
                SplashView
            }
            
            
        }
        .onAppear(){
            animateText()
        }
        
       
}
    
var SplashView : some View{
        ZStack(alignment: .center){
            
            //            Background
            BackgroundView()
            
            VStack(alignment: .leading) {
                Text("Welcome To")
                    .font(.largeTitle)
                    .fontDesign(.rounded)
                    .foregroundColor(.orange)
                    .opacity(opacity)
                    .offset(y: offsetUp)
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 2), value: opacity)
                    .animation(.easeInOut(duration: 3), value: scale)
                
                Text("Sentiment Analyzer...")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .foregroundColor(.white)
                    .opacity(opacity)
                    .offset(y: offsetDown)
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 2), value: opacity)
                    .animation(.easeInOut(duration: 3), value: scale)
                
            }
            
            
        }
    }
    
    
    

func animateText() {
            opacity = 0
            scale = 0.0
            offsetUp = 0
            offsetDown = 0
        
            // Fade in
    withAnimation(.easeInOut(duration: 1)) {
                opacity = 1
                scale = 1.0
            }
        
        withAnimation(.easeInOut(duration: 1.5).delay(3)) {
            offsetUp = -500      // moves upward
            offsetDown = 500// moves downward
            
           }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation {
                goToHome = true
            }
        }
    

        }
    }


#Preview {
    SplashScreen()
}
