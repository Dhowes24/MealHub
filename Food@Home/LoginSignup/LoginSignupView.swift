//
//  LoginSignupView.swift
//  Food@Home
//
//  Created by Derek Howes on 11/5/23.
//

import SwiftUI

struct LoginSignupView: View {
    @Namespace private var animation
    @State private var defaultStatus: Bool = true
    @State private var email: String = ""
    @State private var loggingIn: Bool = false
    @State private var signingUp: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack() {
                Group {
                    Text("Welcome to Food at Home")
                        .font(.customSystem(size: 24, weight: .bold))
                        .frame(height: 18)
                        .padding(.top, 80)
                    Text("Rita Stegman")
                        .font(.customSystem(size: 18, weight: .bold))
                        .frame(height: 18)
                        .padding(.vertical, 8)
                }
                
                Logo(frameSize: 180)
                    .padding(.top, 60)
                
                if defaultStatus {
                    VStack(spacing: 24) {
                        Text("Log in")
                            .button(color: "black")
                            .matchedGeometryEffect(id: "Login", in: animation)
                            .onTapGesture {
                                withAnimation {
                                    defaultStatus.toggle()
                                    loggingIn.toggle()
                                }
                            }
                        
                        Text("Sign up")
                            .button(color: "white")
                            .matchedGeometryEffect(id: "SignUp", in: animation)
                            .onTapGesture {
                                withAnimation {
                                    defaultStatus.toggle()
                                    signingUp.toggle()
                                }
                            }
                    }
                    .padding(.top, 90)
                    
                }
                else if loggingIn {
                    
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.customSystem(size: 16, weight: .bold))
                            .padding(.bottom, 9)
                        TextField("Enter your email address", text: $email)
                            .textInputMod()
                            .padding(.bottom, 24)
                        
                        Text("Password")
                            .font(.customSystem(size: 16, weight: .bold))
                            .padding(.bottom, 9)
                        TextField("Enter your password", text: $email)
                            .textInputMod()
                            .padding(.bottom, 24)

                    }
                    .frame(height: 300)
                    .padding(.horizontal, 16)
                    
                    Text("Log in")
                        .button(color: "black")
                        .matchedGeometryEffect(id: "Login", in: animation)
                        .onTapGesture {
                            withAnimation {
                                defaultStatus.toggle()
                                loggingIn.toggle()
                            }
                        }
                }
                else if signingUp {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .font(.customSystem(size: 16, weight: .bold))
                            .padding(.bottom, 9)
                        TextField("Enter your email address", text: $email)
                            .textInputMod()
                            .padding(.bottom, 24)
                        
                        Text("Password")
                            .font(.customSystem(size: 16, weight: .bold))
                            .padding(.bottom, 9)
                        TextField("Enter your password", text: $email)
                            .textInputMod()
                            .padding(.bottom, 24)
                        
                        Text("Re-enter Password")
                            .font(.customSystem(size: 16, weight: .bold))
                            .padding(.bottom, 9)
                        TextField("Re-enter your password", text: $email)
                            .textInputMod()
                            .padding(.bottom, 24)
                    }
                    .frame(height: 300)
                    .padding(.horizontal, 16)
                    
                    Text("Sign up")
                        .button(color: "white")
                        .matchedGeometryEffect(id: "SignUp", in: animation)
                        .onTapGesture {
                            withAnimation {
                                defaultStatus.toggle()
                                signingUp.toggle()
                            }
                        }
                }
                Spacer()
                
            }
            .frame(width: geometry.size.width)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginSignupView()
}
