//
//  ContentView.swift
//  CustomNavBar
//
//  Created by 이호영 on 2022/03/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewTab : String = "home"
    @State var togglePosition : Bool = false
    @State var toggleMenu : Bool = false
    
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            
            switch viewTab {
                case "home" : HomeView()
                case "message" : MessageView()
                case "user" : UserView()
                default: HomeView()
            }
            //하단 네비게이션 바 영역
            HStack{
                if !togglePosition { Spacer() }
                NavBar(viewTab: $viewTab, togglePosition: $togglePosition, toggleMenu: $toggleMenu)
                    .padding().gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({
                        value in
                        if value.translation.width < 0 {
                            withAnimation(.default){
                                togglePosition = true}
                        }
                        if value.translation.width > 0 {
                            withAnimation(.default){
                                togglePosition = false}
                        }
                    }))
                if togglePosition { Spacer() }
            }
        }
    }
}

//MARK: - 네비게이션바 시작
struct NavBar: View {
    @Binding var viewTab : String
    @Binding var togglePosition : Bool
    @Binding var toggleMenu : Bool
    
    let MENULIST = ["1.message":"message.fill","0.home":"house.fill","2.user":"person.crop.circle","3.menu":"line.3.horizontal"]
    
    var body: some View {
        
        //버튼영역
        HStack(alignment: .center, spacing: 40){
            Spacer()
            
            Group{
                
                ForEach(togglePosition ? MENULIST.sorted(by: >) : MENULIST.sorted(by: <), id: \.key){ key, value in
                    
                    
                    if (key != "3.menu"){
                        
                        if toggleMenu == true {
                            Button(action:{
                                viewTab = String(key.dropFirst(2))
                                print("\(key):\(toggleMenu)")
                            }){
                                Image(systemName: value)
                                    .foregroundColor(viewTab == String(key.dropFirst(2)) ? .primary : .secondary)
                            }
                        }
                        
                    } else {
                        
                        Button(action:{
                            withAnimation(.linear){
                                toggleMenu.toggle()}
                            print("\(key):\(toggleMenu)")
                        }){
                            Image(systemName: value)}
                        
                    }
                    
                }
                
                
            }.foregroundColor(.primary).colorInvert()
            Spacer()
            
            
        }.frame(width: toggleMenu ? 250 : 50, height: 50).background(RoundedRectangle(cornerRadius: 30))
        
    }
}

struct MessageView: View {
    var body: some View {
        
        VStack{
            Spacer()
            Text("Message")
            Spacer()
        }.background()
        
        
    }
}


struct HomeView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("Home")
            Spacer()
        }.background()
    }
}

struct UserView: View {
    var body: some View {
        VStack{
            Spacer()
            Text("User")
            Spacer()
        }.background()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        
    }
}

