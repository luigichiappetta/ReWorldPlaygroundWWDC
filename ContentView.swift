//
//  ContentView.swift
//  ReWorldPlaygroundWWDC2024
//
//  Created by Luigi Chiappetta on 30/01/2024.
//

import Foundation
import Combine
import SwiftUI
import RealityKit
import SceneKit
import FocusEntity
import ARKit
import AVFoundation

struct StartingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("StartingScreen")
                NavigationLink(destination: {
                    
                    ExplainingView()
                        .navigationBarBackButtonHidden(true)
                    
                }, label: {
                    
                    Text("Start")
                    
                        .foregroundColor(.white)
                    
                        .padding(.vertical)
                    
                        .padding(.horizontal, 50)
                    
                        .background(.green)
                    
                        .cornerRadius(10)
                })
            }
        }
    }
}


struct ExplainingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("ExplainingScreen")
                NavigationLink(destination: {
                    ContentView()
                        .navigationBarBackButtonHidden(true)
                }, label: {
                    Text("Next")
                        .foregroundColor(.white)
                    
                        .padding(.vertical)
                    
                        .padding(.horizontal, 20)
                    
                        .background(.green)
                    
                        .cornerRadius(10)
                })
            }
        }
    }
}

struct WinningView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("WinningScreen")
                
                VStack {
                    
                    Text("YOU SAVED THE WORLD!")
                    
                        .font(.title)
                    
                        .foregroundColor(.green)
                    
                        .bold()
                    
                        .padding(.vertical, -300)
                    
                        .padding(.horizontal, 100)
                }
            }
        }
    }
}

struct LosingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("LosingScreen")
                
                VStack {
                    
                    Text("THE END IS NEAR! YOU LOSE!")
                    
                        .font(.title)
                    
                        .foregroundColor(.red)
                    
                        .bold()
                    
                        .padding(.vertical)
                    
                        .padding(.horizontal, 50)
                }
            }
        }
    }
}

public struct ContentView: View {
    
    @State private var showButton = true
    @State private var scrolling = false
    @State public var cityLife = 50
    
    @State public var isPlastic = false
    @State public var isPaper = false
    @State public var isGlass = false
    @State public var isMetal = false
    
    @State private var offset: CGFloat = -50

    public var body: some View {
        
        ZStack(alignment: .bottom) {
            
            CustomARViewContainer()
            
            VStack {
                HStack {
                    Spacer(minLength: 200)
                    Text("City Life: \(cityLife)")
                        .foregroundStyle(.black)
                        .font(.title)
                        .bold()
                        .background(.green)
                        .cornerRadius(10)
                        .position(x: 100, y: 40)
                }
                
                HStack {
                    Button(action: {
                        if isPlastic {
                            cityLife += 5
                        } else {
                            cityLife -= 5
                        }
                    }, label: {
                        Text("PLASTIC")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .cornerRadius(10)
                            .bold()
                    })
                    
                    Button(action: {
                        if isMetal {
                            cityLife += 5
                        } else {
                            cityLife -= 5
                        }
                    }, label: {
                        Text("METAL")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                            .bold()
                    })
                    
                    Button(action: {
                        if isPaper {
                            cityLife += 5
                        } else {
                            cityLife -= 5
                        }
                    }, label: {
                        Text("PAPER")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .bold()
                    })
                    
                    Button(action: {
                        if isGlass {
                            cityLife += 5
                        } else {
                            cityLife -= 5
                        }
                    }, label: {
                        Text("GLASS")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .bold()
                    })
                }
                
                if showButton {
                    Button(action: {
                        ActionManager.shared.actionStream.send(.place3DModel)
                        showButton = false
                        scrolling = true
                    }, label: {
                        Text("Place Cans")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    .padding(.bottom, 50)
                }
                
                if scrolling {
                    makeScrollView()
                }
            }
            
            if cityLife == 100 {
                WinningView()
            } else if cityLife == 0 {
                LosingView()
            }
        }
    }
    
    func makeScrollView() -> some View {
        ScrollView(.horizontal) {
            HStack {
                Spacer(minLength: 80)
                Image("Cardboard")
                    .onTapGesture {
                        isGlass = false
                        isMetal = false
                        isPlastic = false
                        isPaper = true
                    }
                Spacer(minLength: 190)
                Image("Paper_Waste")
                    .onTapGesture {
                        isGlass = false
                        isMetal = false
                        isPlastic = false
                        isPaper = true
                        
                    }
                Spacer(minLength: 225)
                Image("Magnifying_Glass")
                    .onTapGesture {
                        isMetal = false
                        isPaper = false
                        isPlastic = false
                        isGlass = true
                    }
                Spacer(minLength: 220)
                Image("Alluminium_Foil")
                    .onTapGesture {
                        isGlass = false
                        isPaper = false
                        isPlastic = false
                        isMetal = true
                    }
                Spacer(minLength: 260)
                Image("Glass")
                    .onTapGesture {
                        isMetal = false
                        isPaper = false
                        isPlastic = false
                        isGlass = true
                    }
                Spacer(minLength: 285)
                Image("Plastic_Bag")
                    .onTapGesture {
                        isGlass = false
                        isPaper = false
                        isMetal = false
                        isPlastic = true
                    }
                Spacer(minLength: 215)
                Image("Plastic_Spoon")
                    .onTapGesture {
                        isGlass = false
                        isPaper = false
                        isMetal = false
                        isPlastic = true
                    }
                Spacer(minLength: 260)
                Image("Glass_Bottle")
                    .onTapGesture {
                        isMetal = false
                        isPaper = false
                        isPlastic = false
                        isGlass = true
                    }
                Spacer(minLength: 265)
                Image("Metal_Fork")
                    .onTapGesture {
                        isGlass = false
                        isPaper = false
                        isPlastic = false
                        isMetal = true
                    }
                Spacer(minLength: 200)
                Image("Glass_Bowl")
                    .onTapGesture {
                        isMetal = false
                        isPaper = false
                        isPlastic = false
                        isGlass = true
                    }
                Spacer(minLength: 200)
                Image("Plastic_Bottle")
                    .onTapGesture {
                        isGlass = false
                        isPaper = false
                        isMetal = false
                        isPlastic = true
                    }
                Spacer(minLength: 250)
                Image("Plastic_Cup")
                    .onTapGesture {
                        isGlass = false
                        isPaper = false
                        isMetal = false
                        isPlastic = true
                    }
                Spacer(minLength: 225)
                Image("Glasses")
                    .onTapGesture {
                        isMetal = false
                        isPaper = false
                        isPlastic = false
                        isGlass = true
                    }
                Spacer(minLength: 185)
                Image("Metal_Tins")
                    .onTapGesture {
                        isGlass = false
                        isPaper = false
                        isPlastic = false
                        isMetal = true
                    }
                Spacer(minLength: 105)
            }
        }
        .scrollTargetBehavior(.paging)
    }
}

struct CustomARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CustomARView {
        let arView = CustomARView()
        return arView
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) { }
}

class CustomARView: ARView {
    
    var focusEntity: FocusEntity?
    var cancellables: Set<AnyCancellable> = []

    init() {
        super.init(frame: .zero)

        subscribeToActionStream()

        self.focusEntity = FocusEntity(on: self, style: .classic(color: .yellow))

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        }

        self.session.run(config)
    }
    
    func subscribeToActionStream2() {
        ActionManager.shared
            .actionStream
            .sink { [weak self] action in
                
                switch action {

                case .place3DModel:
                    self?.place3DModel()
                    
                case .remove3DModel:
                    print("Removing 3D model: has not been implemented")
                }
            }
            .store(in: &cancellables)
    }

    func place3DModel() {
        guard let focusEntity = self.focusEntity else { return }

        let modelEntity0 = try! ModelEntity.load(named: "Trash_Can", in: nil)
        let anchorEntity0 = AnchorEntity(world: focusEntity.position)
        anchorEntity0.addChild(modelEntity0)
        let newTransform = Transform(scale: .init(x: 0.06, y: 0.06, z: 0.06), rotation: .init(ix: 0, iy: 1, iz: 0, r: 1))
        modelEntity0.move(to: newTransform, relativeTo: modelEntity0)
        modelEntity0.setPosition(SIMD3(x: 700, y: 0, z: 0), relativeTo: modelEntity0)
        self.scene.addAnchor(anchorEntity0)
    }
    
    func subscribeToActionStream() {
        ActionManager.shared
            .actionStream
            .sink { [weak self] action in
                
                switch action {
                    
                case .place3DModel:
                    self?.place3DModel()
                    
                case .remove3DModel:
                    print("Removing 3D model: has not been implemented")

                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}

enum Actions {
    case place3DModel
    case remove3DModel
}

class ActionManager {
    static let shared = ActionManager()
    
    private init() { }
    
    var actionStream = PassthroughSubject<Actions, Never>()
}

struct StartingView_Previews: PreviewProvider {
    static var previews: some View {
        StartingView()
    }
}


