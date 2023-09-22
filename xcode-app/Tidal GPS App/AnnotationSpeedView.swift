//
//  AnnotationSpeedView.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/21/23.
//

import Foundation
import SwiftUI

struct AnnotationSpeedView: View {
  var body: some View {
    VStack(spacing: 0) {
      Image(systemName: "mappin.circle.fill")
        .font(.title)
        .foregroundColor(.red)
      
      Image(systemName: "arrowtriangle.down.fill")
        .font(.caption)
        .foregroundColor(.red)
        .offset(x: 0, y: -5)
    }
  }
}
