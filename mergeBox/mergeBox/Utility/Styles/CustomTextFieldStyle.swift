//
//  CustomTextFieldStyle.swift
//  mergeBox
//
//  Created by 松浦壮吾 on 2025/11/27.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundStyle(.white)
            .tint(.white)
            .padding()
            .background(.white.opacity(0.5))
            .clipShape(
                RoundedRectangle(cornerRadius: 5)
            )
    }
}

extension TextFieldStyle where Self == CustomTextFieldStyle {
    static var customTextField : CustomTextFieldStyle {
        CustomTextFieldStyle()
    }
}

#Preview {
    @Previewable @State var text = ""
    ZStack {
        Color(.Login.Colors.background1)
        TextField("ユーザーID", text: $text)
            .textFieldStyle(
                CustomTextFieldStyle()
            )
            .padding(20)
    }
}
