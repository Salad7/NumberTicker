//
//  ContentView.swift
//  NumberTickerExample
//
//  Created by Niklas Fahl on 3/27/20.
//  Copyright © 2020 Nik Fahl. All rights reserved.
//

import SwiftUI
import NumberTicker

extension FloatingPoint {
  var isInteger: Bool { rounded() == self }
}

struct ContentView: View {
    @State var currentNumber = 46051.74 * 4
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            TopBanner()
            Text("Investing")
                .fontWeight(.medium)
                .padding(4)
                .font(.custom("SF Pro", size: 32))
            NumberTicker(number: currentNumber, decimalPlaces: 2, numberStyle: NumberFormatter.Style.currencyAccounting, font: .custom("Helvetica Neue", size: 32))
            Subtext()
            Spacer()
            Stepper(value: $currentNumber, in: 0...1050000, step: 5.25) {
                Text("\(currentNumber)")
            }.opacity(0)
            Slider(value: $currentNumber, in: 0...1050000, step: 0.01)
            Text("Number reference: \(currentNumber)").opacity(0)
        }
        .padding(16)
    }
    
}

struct TopBanner: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("top_banner")
                .resizable()
                .frame(width: 400, height: 56)
        }
        .frame(maxWidth: 32, maxHeight: 48, alignment: .topLeading) // Ensure it fills the screen horizontally
        .padding(.init(top: -16, leading: -16, bottom: 0, trailing: 0))
        // Align the VStack to the top-left

    }
    
}

struct Subtext: View {
    
    var body: some View {
        Spacer().frame(height: 6)
        HStack() {
            Image("green")
                .resizable()
                .frame(width: 14, height: 18)
            Spacer().frame(width: 6)
            Text("$62,446.38 (37.03%)")
                .font(.system(size: 14, weight: .semibold, design: .default))
                .foregroundColor(Color(red: 0.0, green: 0.784, blue: 0.325))
                                 
                                 
            Text("Year to date")
                .font(.custom("SF Pro", size: 14))

        }
        .padding(4)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = scanner.string.startIndex
        var rgb: UInt64 = 0
        
        if scanner.scanHexInt64(&rgb) {
            let r = Double((rgb & 0xFF0000) >> 16) / 255.0
            let g = Double((rgb & 0x00FF00) >> 8) / 255.0
            let b = Double(rgb & 0x0000FF) / 255.0
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(white: 0.0)  // Default to black if hex is invalid
        }
    }
}
