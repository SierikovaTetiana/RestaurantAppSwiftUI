//
//  CheckOutView.swift
//  DeGustoSwiftUI
//
//  Created by Tetiana Sierikova on 11.08.2022.
//

import SwiftUI

struct CheckOutView: View {
    
    @State private var takeAwayOrDelivery = 0
    @State var text = ""
    @State var readyToNow = true
    @State private var currentDate = Date()
    
    var body: some View {
        VStack {
            pickerView
            personalData
            userComment
            readyTo
            Spacer()
            bottomText
            sendOrder
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView()
    }
}

extension CheckOutView {
    var pickerView: some View {
        VStack(alignment: .leading) {
            Text("Як Ви хочете отримати своє замовлення?")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
            Picker("", selection: $takeAwayOrDelivery) {
                Text("Самовивіз").tag(0)
                Text("Доставка").tag(1)
            }
            .pickerStyle(.segmented)
        }.padding()
    }
    
    var personalData: some View {
        VStack(alignment: .leading) {
            Text("Персональні дані")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
            ForEach([ProfileViewModel.name, ProfileViewModel.phone], id: \.rawValue) { item in
                HStack {
                    Image(systemName: item.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .leading)
                        .foregroundColor(Color("darkGreen"))
                    TextField("\(item.description)", text: $text)
                        .padding(.leading)
                }
                Divider()
            }
        }.padding()
    }
    
    var userComment: some View {
        VStack(alignment: .leading) {
            Text("Коментар до замовлення")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
            TextField("Ваші побажання", text: $text)
                .multilineTextAlignment(.leading)
            Divider()
        }.padding()
    }
    
    var readyTo: some View {
        VStack(alignment: .leading) {
            Text("Приготувати до:")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color("darkGreen"))
                .padding(.bottom)
            HStack {
                Button {
                    readyToNow = true
                    print("ready to now")
                } label: {
                    Text("Як можна скоріше")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(Color.black)
                }
                Spacer()
                if readyToNow {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color("darkGreen"))
                }
            }
            Divider()
            HStack {
                Button {
                    readyToNow = false
                    print("ready to now")
                } label: {
                    DatePicker("", selection: $currentDate, displayedComponents: [.date, .hourAndMinute])
                        .labelsHidden()
                }
                Spacer()
                if !readyToNow {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color("darkGreen"))
                }
            }
            Divider()
        }.padding()
    }
    
    var bottomText: some View {
        Text("Оплатити замовлення Ви можете за допомогою терміналу чи готівкою")
            .font(.system(.callout, design: .rounded))
            .foregroundColor(Color("darkGreen"))
            .padding(.bottom)
    }
    
    var sendOrder: some View {
        Button(action: {
            print("Go to the menu")
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .circular)
                    .foregroundColor(Color("darkRed"))
                    .frame(width: 250, height: 50)
                Text("Відправити замовлення")
            }
        }
        .foregroundColor(.white)
    }
}
