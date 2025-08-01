//import SwiftUI
//import SpriteKit
//
//class ImageEmitterScene: SKScene {
//    let particleTexture: SKTexture
//    var spawnTimer: Timer?
//
//    init(size: CGSize, imageName: String) {
//        self.particleTexture = SKTexture(imageNamed: imageName)
//        super.init(size: size)
//        backgroundColor = .clear
//        scaleMode = .resizeFill
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func didMove(to view: SKView) {
//        startSpawning()
//    }
//
//    override func willMove(from view: SKView) {
//        spawnTimer?.invalidate()
//    }
//
//    func startSpawning() {
//        spawnTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            self?.spawnParticle()
//        }
//    }
//
//    func spawnParticle() {
//        let particle = SKSpriteNode(texture: particleTexture)
//        particle.size = CGSize(width: 23, height: 30)
//        let xPos = CGFloat.random(in: 0...size.width)
//        particle.position = CGPoint(x: xPos, y: size.height + particle.size.height)
//        particle.zPosition = 1
//        addChild(particle)
//
//        let duration = Double.random(in: 12.0...12.0)
//        let moveAction = SKAction.moveTo(y: -particle.size.height, duration: duration)
//        let removeAction = SKAction.removeFromParent()
//        particle.run(SKAction.sequence([moveAction, removeAction]))
//    }
//}
//
//struct ImageEmitterView: View {
//    let scene: SKScene
//
//    init(imageName: String) {
//        let screenSize = UIScreen.main.bounds.size
//        scene = ImageEmitterScene(size: screenSize, imageName: imageName)
//    }
//
//    var body: some View {
//        SpriteView(
//            scene: scene,
//            options: [.allowsTransparency]
//        )
//        .ignoresSafeArea()
//        .background(Color.clear)
//    }
//} 
