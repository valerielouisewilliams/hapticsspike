//
//  ContentView.swift
//  hapticstest
//
//  Created by Valerie Williams on 6/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tapped = UUID()
    @State private var longPressed = UUID()
    @State private var hapticsEnabled = true
    
    
    
    public var body: some View {
        content
    }
    
    var content: some View {
        VStack {
            self.button1
            self.button2
            self.button3
            self.button4
            self.button5
            self.button6
        }
    }
    
    private var button1: some View {
        VStack {
            Button(action: taptap) {
                Text("Tap this Button!")
            }
            .modifier(SensoryFeedbackIfAvailable(trigger: tapped, haptic: "success", hapticsEnabled: hapticsEnabled))
        }
    }
    
    private var button2: some View {
        VStack {
            Button(action: taptap) {
                Text("Tap this Button!")
            }
            .modifier(SensoryFeedbackIfAvailable(trigger: tapped, haptic: "warning", hapticsEnabled: hapticsEnabled))
        }

    }
    
    private var button3: some View {
        VStack {
            Button(action: taptap) {
                Text("Tap this Button!")
            }
            .modifier(SensoryFeedbackIfAvailable(trigger: tapped, haptic: "error", hapticsEnabled: hapticsEnabled))
        }

    }
    
    private var button4: some View {
        VStack {
            Button(action: taptap) {
                Text("Tap this Button!")
            }
            .modifier(SensoryFeedbackIfAvailable(trigger: tapped, haptic: "impact", hapticsEnabled: hapticsEnabled))
        }

    }
    
    private var button5: some View {
        VStack {
            Button(action: taptap) {
                Text("Tap this Button!")
            }
            .modifier(SensoryFeedbackIfAvailable(trigger: tapped, haptic: "start", hapticsEnabled: hapticsEnabled))
        }
    }
    
    private var button6: some View {
        VStack {
            Button(action: { print("hi") }) {
                Text("Tap this button in diff ways!")
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        print("Tapped helloooo")
                        tapped = UUID()
                    }
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        print("Long pressed")
                        longPressed = UUID()
                    }
            )
            .sensoryFeedback(.impact(weight: .medium), trigger: tapped)
            .sensoryFeedback(.impact(weight: .heavy), trigger: longPressed)
        }
    }
    
    
    private func taptap() {
        self.tapped = UUID() // Change the UUID so that we can deploy the sensory feedback the next time
    }
    
}

struct SensoryFeedbackIfAvailable: ViewModifier {
    var trigger: UUID
    var haptic: String
    @State var hapticsEnabled: Bool
    
    func body(content: Content) -> some View {
        if hapticsEnabled, #available(iOS 17.0, *) {
            switch haptic {
            case "success":
                content.sensoryFeedback(.success, trigger: trigger)
            case "warning":
                content.sensoryFeedback(.warning, trigger: trigger)
            case "error":
                content.sensoryFeedback(.error, trigger: trigger)
            case "impact":
                content.sensoryFeedback(.impact, trigger: trigger)
            case "start":
                content.sensoryFeedback(.start, trigger: trigger)
            default:
                content
            }
        } else {
            content
        }
    }
}
