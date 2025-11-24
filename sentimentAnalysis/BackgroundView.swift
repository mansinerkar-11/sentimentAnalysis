//
//  BackgroundView.swift
//  Review Analysis AI
//
//  Created by Mansi Nerkar on 21/11/25.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [.black, .gray.opacity(0.4)], startPoint: .top, endPoint: .bottom
            
            )
        .ignoresSafeArea()
    }
    
}

#Preview {
    BackgroundView()
}
