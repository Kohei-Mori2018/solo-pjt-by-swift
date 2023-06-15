//
//  ContentView.swift
//  part18_counterApp
//
//  Created by user on 2023/06/14.
//

import SwiftUI
import UIKit // こちらも必要
import GoogleMobileAds // 忘れずに

struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize:  GADAdSizeFromCGSize(CGSize(width: 320, height: 50))) // インスタンスを生成
        // 諸々の設定をしていく
        banner.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        // 自身の広告IDに置き換える
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner // 最終的にインスタンスを返す
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
        // 特にないのでメソッドだけ用意
    }
}


struct ContentView: View {
    @AppStorage ("saveCountTabacco") var saveCountTabacco = 0
    @AppStorage ("saveCostTabacco") var saveCostTabacco = 0
    @AppStorage ("costTabacco") var costTabacco = 0
    @AppStorage ("countTabacco") var countTabacco = 0
    @AppStorage ("co2Tabacco") var co2Tabacco = 0
    @AppStorage ("saveLoseLife") var saveLoseLife = 0
    @State private var showAleart = false
    @State private var showConfirm = false
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            VStack {
                AdMobBannerView().frame(width: 340, height: 50).padding(.top,30)
                Text("👍我慢したタバコは\(saveCountTabacco)本です！")
                    .font(.system(size:20,weight: .bold,design: .default)).foregroundColor(.red)
                Text("👍節約したタバコ代は\(saveCostTabacco)円です！")
                    .font(.system(size:20,weight: .bold,design: .default)).foregroundColor(.red)
                Text("🫵吸ったタバコ代は\(costTabacco)円です！")
                    .font(.system(size:20,weight: .bold,design: .default)).foregroundColor(.blue)
                Text("🫵縮まった寿命は\(saveLoseLife)分です！")
                    .font(.system(size:20,weight: .bold,design: .default)).foregroundColor(.blue)
                Text("🫵排出した二酸化炭素は\(co2Tabacco)Lです！")
                    .font(.system(size:20,weight: .bold,design: .default)).foregroundColor(.blue)
                Image("smoking")
                Spacer()
                HStack{
                    Button {
                        saveCountTabacco = saveCountTabacco + 1
                        saveCostTabacco += 30
                    } label:{
                        Text("👼我慢💕")
                            .frame(height: UIScreen.main.bounds.height/5)
                            .frame(maxWidth: .infinity)
                            .background(Color("PlusButtonColor"))
                            .foregroundColor(.white)
                            .font(.system(size:30,weight: .bold,design: .default))
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button {
                        showConfirm = true
                    } label: {
                        Text("☠️吸う🚬")
                            .frame(height: UIScreen.main.bounds.height/5)
                            .frame(maxWidth: .infinity)
                            .background(Color("MinusButtonColor"))
                            .foregroundColor(.white)
                            .font(.system(size:30,weight: .bold,design: .default))
                            .cornerRadius(10)
                    } .alert("警告", isPresented: $showConfirm) {
                        Button("それでも吸う",role: .destructive){
                            countTabacco += 1
                            costTabacco += 30
                            saveLoseLife += 6
                            co2Tabacco += 2
                            showConfirm = false
                        }
                        Button("一回考える",role: .cancel) {
                            showConfirm = false
                        }
                    } message: {
                        Text("吸うごとにパートナーへ通知します。いいですか？")
                    }
                }
                Button {
                    showAleart = true
                } label:{
                    Text("全てを無かったことにする")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.white)
                        .foregroundColor(.red)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(.red, lineWidth:1))
                }.padding(.bottom,30)
                .alert("警告", isPresented: $showAleart) {
                    Button("無に返す",role: .destructive){
                        countTabacco = 0
                        saveCountTabacco = 0
                        saveCostTabacco = 0
                        costTabacco = 0
                        countTabacco = 0
                        co2Tabacco = 0
                        saveLoseLife = 0
                        showAleart = false
                    }
                    Button("戻る",role: .cancel) {
                        showAleart = false
                    }
                } message: {
                    Text("こんなことをして恥ずかしくないですか？Keep on doing!!")
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
