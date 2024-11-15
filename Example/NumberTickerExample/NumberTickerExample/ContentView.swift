//
//  ContentView.swift
//  NumberTickerExample
//
//  Created by Niklas Fahl on 3/27/20.
//  Copyright © 2020 Nik Fahl. All rights reserved.
//

import SwiftUI
import NumberTicker
import RHLinePlot

extension FloatingPoint {
  var isInteger: Bool { rounded() == self }
}


struct PageOne: View {
    @State var currentNumber = 46051.74 * 4
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 1) {
                TopBanner()
                Text("Investing")
                    .fontWeight(.medium)
                    .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 0))
                    .font(.custom("SFProDisplay-Medium", size: 32))
                NumberTicker(number: currentNumber, decimalPlaces: 2, numberStyle: NumberFormatter.Style.currencyAccounting, font: .custom("SF Pro Display", size: 32))
                    .padding(.init(top: 4, leading: 16, bottom: 0, trailing: 0))
                Subtext()
                GraphDemo()
                PeriodPicker()
                BuyingPower()
                Spacer()
                Stepper(value: $currentNumber, in: 0...1050000, step: 5.25) {
                    Text("\(currentNumber)")
                }.opacity(0)
                Slider(value: $currentNumber, in: 0...1050000, step: 0.01).opacity(0)
                Text("Number reference: \(currentNumber)").opacity(0)
                StocksList().padding(.init(top: -48, leading: 0, bottom: 0, trailing: 0))
            }
        }
    }
    init(){
//        for familyName in UIFont.familyNames {
//            print(familyName)
//            for fontName in UIFont.fontNames(forFamilyName: familyName){
//                print("-- \(fontName)")
//            }
//        }
    }
}

struct ContentView: View {
    init() {
        let appearance = UITabBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = .white
                appearance.shadowColor = .clear  // Remove any shadows
                UITabBar.appearance().standardAppearance = appearance
    }
    var body: some View {
        BottomNavBar()
    }
}

struct BottomNavBar: View {
    var body: some View {
        TabView {
            // First Tab
            PageOne()
            .tabItem {
                Image(systemName: "house.fill")
            }
            PageTwo()
            .tabItem {
                Image(systemName: "magnifyingglass")
            }
            PageOne()
            .tabItem {
                Image(systemName: "bell.fill")
            }
            PageOne()
            .tabItem {
                Image(systemName: "person.fill")
            }
            PageOne()
            .tabItem {
                Image(systemName: "gearshape.fill")
            }
        }
        .accentColor(.blue)
        .background(Color.clear)
    }
}

struct PageTwo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("crypto")
                .resizable()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Ensure it fills the screen horizontally
        .padding(.init(top: 0, leading: 0, bottom: 80, trailing: 0))
        .background(Color.black)  // Optional: Rounded corners for the VStack
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
        // Align the VStack to the top-left

    }
    
}

struct TopBanner: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image("top_banner")
                .resizable()
                .frame(width: 420, height: 56)
        }
        .frame(maxWidth: 32, maxHeight: 48, alignment: .topLeading) // Ensure it fills the screen horizontally
        .padding(.init(top: -16, leading: 0, bottom: 0, trailing: 0))
        // Align the VStack to the top-left

    }
    
}

struct GraphDemo: View {
    var body: some View {
        var valuesToPlot: [CGFloat] = [11,2,3,4,3,2,15,2,3,4,10,11,13,8,14,14,15,23,41,41,21,35,64,13,21,33,55,100,104,301,205,100,45,180,205,210]
        var segments = [0,4,8]
        
        NumberTicker(number: 146051.71)
        RHInteractiveLinePlot(
            values: valuesToPlot,
            occupyingRelativeWidth: 1.05,
            showGlowingIndicator: false,
            lineSegmentStartingIndices: segments,
            didSelectValueAtIndex: { index in
              // Do sth useful with index...
                
            },
                customLatestValueIndicator: {
                  // Custom indicator...
//                    GlowingIndicator()
                    
            },
                valueStickLabel: { value in
                  // Label above the value stick...
                    Text("Nov 19, 2024")
                        .foregroundColor(Color.gray)
            }
        ).environment(\.rhLinePlotConfig, RHLinePlotConfig.default.custom(f: { (c) in
            c.useLaserLightLinePlotStyle = false
            c.valueStickColor = Color.gray
            
            
            
        })).foregroundColor(Color.green)
            .frame(width: 402,height: 300)
        
    }
}

struct BuyingPower: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider().frame(width: 370, height: 10)
        // Ensure it fills the screen horizontally
        .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 0))
        // Align the VStack to the top-left
            Spacer().frame(height: 18)
        HStack() {
            Text("Buying power")
                .font(.system(size: 16, weight: .regular, design: .default)).padding(.init(top: 0, leading: 20, bottom: 0, trailing: 0))
            Spacer()
            Text("$41,478.60") .font(.system(size: 16, weight: .regular, design: .default))
            Image(systemName: "chevron.right")
                .font(.system(size: 18)) // You can adjust the size
                .padding(.init(top: 0, leading: 4, bottom: 0, trailing: 32))
                .foregroundColor(Color.gray)
        }
            Spacer().frame(height: 24)
            Rectangle().frame(width: 426, height: 8.0)
                .foregroundColor(Color(red: 0.969, green: 0.969, blue: 0.969))
        }.padding(.init(top: -32, leading: 0, bottom: 0, trailing: 0))
    }
    
}

struct Subtext: View {
    
    var body: some View {
        Spacer().frame(height: 12)
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
        .padding(.init(top: -4, leading: 16, bottom: 0, trailing: 0))
    }
}






struct PeriodPicker: View {
    let items = ["1W", "1M", "3M", "YTD", "1Y", "ALL"]
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -8) { // Spacing between items
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            // Action for each item
                            print("\(item) clicked!")
                        }) {
                            Text(item)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.green)
                                .cornerRadius(10)
                                .font(.system(size: 12, weight: .bold, design: .default))
                        }
                        .frame(width: 65, height: 100) // Set the size of each button
                    }
                }
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0)) // Optional padding for the HStack
            }
            Image("settings")
                .resizable()
                .frame(width: 18, height: 18)
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 32))
        }
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


struct GraphDemoSmall: View {
    var body: some View {
        
        var randomValues: [CGFloat] = {
                var values: [CGFloat] = []
                
                // Step 1: Start with a random value between 1 and 10
                var currentValue: CGFloat = CGFloat(Float.random(in: 1...10))
                values.append(currentValue)
                
                // Step 2: Generate the next values by randomly adding or subtracting 0.01 or 0.03
                for _ in 1..<100 {
                    let increment: CGFloat
                    // Randomly choose whether to add or subtract and whether to use 0.01 or 0.03
                    let randomChange = Bool.random() ? 1 : -1  // 1 means add, -1 means subtract
                    let randomAmount = (Bool.random() ? 0.01 : 0.03)  // Either 0.01 or 0.03
                    increment = Double(randomChange) * Double(randomAmount)  // Apply sign and value

                    currentValue += increment
                    values.append(currentValue)
                }
                
                return values
            }()
        
        let valuesToPlot: [CGFloat] = {
            (1...70).map { _ in CGFloat.random(in: -10...100) }
            }()
        
        let segments = [0,4,8]
        
        NumberTicker(number: 146051.71)
        RHInteractiveLinePlot(
            values: randomValues,
            occupyingRelativeWidth: 1,
            showGlowingIndicator: false,
            lineSegmentStartingIndices: segments,
            didSelectValueAtIndex: { index in
              // Do sth useful with index...
                
            },
                customLatestValueIndicator: {
                  // Custom indicator...
//                    GlowingIndicator()
                    
            },
                valueStickLabel: { value in
            }
        ).environment(\.rhLinePlotConfig, RHLinePlotConfig.default.custom(f: { (c) in
            c.useLaserLightLinePlotStyle = false
            c.valueStickColor = Color.gray
            
        })).foregroundColor(Color.green)
            .frame(width: 80,height: 75)
            .scaleEffect(1)
//            .background(Color.blue)
        
    }
}



struct StocksList: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    var pos = 0

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Stocks & ETFs")
                        .multilineTextAlignment(.leading)
                        .font(.custom("SFProDisplay", size: 24))
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20)) // You can adjust the size
                        .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .foregroundColor(Color.gray).frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                List(Array(items.enumerated()), id: \.element) { index, item in
                    // Customize each cell here
                    if(index == 0){
                        CustomCell(item: "MSFT", name: "MSFT", shares: "72.7", ret: "+$411.34")
                            .padding(.init(top: 0, leading: -30, bottom: 0, trailing: 0))
                    }
                    else if(index == 1){
                        CustomCell(item: "PYPL", name: "PYPL", shares: "8.53327", ret: "+$59.99")
                            .padding(.init(top: 0, leading: -30, bottom: 0, trailing: 0))
                    }
                    else if(index == 2){
                        CustomCell(item: "AVGO", name: "AVGO", shares: "780", ret: "+$620.99")
                            .padding(.init(top: 0, leading: -30, bottom: 0, trailing: 0))
                    }
                    else if(index == 3){
                        CustomCell(item: "AAPL", name: "AAPL", shares: "142", ret: "+$920.99")
                            .padding(.init(top: 0, leading: -30, bottom: 0, trailing: 0))
                    }
                    else if(index == 4){
                        CustomCell(item: "TSLA", name: "TSLA", shares: "2", ret: "+$120.27")
                            .padding(.init(top: 0, leading: -30, bottom: 0, trailing: 0))
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
                .padding(.init(top: -14, leading: 0, bottom: 0, trailing: 0))// Works in iOS 13 and later
            }.background(Color.white)
                .padding(.init(top: 0, leading: 20, bottom: -0, trailing: 20))
                .listRowInsets(EdgeInsets()) // Remove separators by removing row insets
                .listStyle(PlainListStyle())
                .disabled(true)
        }.padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

func getStock(name: String, shares: String) -> any View {
    var maxWidth = CGFloat(120)
    return VStack {
        Text(name)
            .multilineTextAlignment(.leading)
            .font(.system(size: 16, weight: .regular, design: .default)).frame(maxWidth: maxWidth, alignment: .leading)
            .foregroundColor(Color.black)
        Spacer().frame(height: 4)
        Text(shares+" shares")
            .font(.system(size: 12, weight: .regular, design: .default))
            .frame(maxWidth: maxWidth, alignment: .leading)
            .foregroundColor(Color.gray)
    }
}
struct CustomCell: View {
    var item: String
    var name: String
    var shares: String
    var ret: String

    var body: some View {
        var maxWidth = CGFloat(120)
        HStack {
            VStack {
                Text(name)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16, weight: .regular, design: .default)).frame(maxWidth: maxWidth, alignment: .leading)
                    .foregroundColor(Color.black)
                Spacer().frame(height: 4)
                Text(shares+" shares")
                    .font(.system(size: 12, weight: .regular, design: .default))
                    .frame(maxWidth: maxWidth, alignment: .leading)
                    .foregroundColor(Color.gray)
            }
            .padding()
            GraphDemoSmall()
            Spacer()
            VStack {
                        // Green box with rounded corners
                Text(ret)
                    .font(.system(size: 14, weight: .light))  // Set the font size for the text
                            .foregroundColor(.black)  // Set the text color to black
                            .frame(width: 80, height: 31)  // Set the size of the box
                            .background(Color(red: 0.0, green: 0.884, blue: 0.325))  // Set the background color to green
                            .cornerRadius(4)  // Apply rounded corners with a radius of 20
                    } // Make sure it takes full screen if necessary
                    .background(Color.white)
                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: -16))// Background color for the whole screen
        }.padding(.init(top: 0, leading: 0, bottom: -10, trailing: 0))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        StocksList()
        ContentView()
    }
}


