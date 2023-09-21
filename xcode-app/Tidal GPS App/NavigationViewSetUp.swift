//
//  NavigationViewSetUp.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/20/23.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct NewContentView: View {
    @State var showSheetView = false
    
    var body: some View {
        NavigationView {
            Text("Content")
            .navigationBarTitle("SwiftUI Tutorials")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showSheetView.toggle()
                }) {
                    Image(systemName: "bell.circle.fill")
                        .font(Font.system(.title))
                }
            )
        }.sheet(isPresented: $showSheetView) {
//            SheetView()
        }
    }
}
