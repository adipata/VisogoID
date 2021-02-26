//
//  PhotoCapture.swift
//  VisogoID
//
//  Created by Adrian on 02/02/2021.
//

import SwiftUI

struct PhotoCapture: View {
    
    @State var image: Image? = nil
    @State var showCaptureImageView: Bool = false
    
    var body: some View {
        ZStack {
              VStack {
                Button(action: {
                  self.showCaptureImageView.toggle()
                }) {
                  Text("Choose photos")
                }
                image?.resizable()
                    .aspectRatio(contentMode: .fit)
                  .frame(width: 250, height: 200)
                  .clipShape(Rectangle())
                  .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
                  .shadow(radius: 10)
              }
              if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, image: $image)
              }
            }
    }
}

struct PhotoCapture_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCapture()
    }
}

struct CaptureImageView {
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    func makeCoordinator() -> Coordinator {
      return Coordinator(isShown: $isShown, image: $image)
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
    }
}
