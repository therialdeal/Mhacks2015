//
//  GameScene.swift
//  MHacks2015
//
//  Created by Ria Sarkar on 9/12/15.
//  Copyright (c) 2015 Ria Sarkar. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var player = SKSpriteNode(imageNamed: "johncena.png")
    var ring = SKSpriteNode(imageNamed: "wrestlingring.png")
    var touchPoint: CGPoint = CGPoint()
    var touching: Bool = false
    
    let playerCategory:UInt32 = 0x1 << 0
    let ringCategory:UInt32 = 0x1 << 1
    
    override func didMoveToView(view: SKView) {
        self.updateEdgeLoop()
        self.backgroundColor = SKColor .whiteColor()
        createPlayer()
        addChild(ring)
        //createRing()
        
    }
    
    override func didChangeSize(oldSize: CGSize) {
        self.updateEdgeLoop()
        
        //player.position = CGPointMake(self.size.width/12, self.size.height/6)
        //player.size = CGSize(width: 50, height: 50)
        //player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        ring.position = CGPointMake(((10*self.size.width)/12),(self.size.height/6))
        ring.size = CGSize(width: 200, height: 200)
        ring.physicsBody = SKPhysicsBody(rectangleOfSize: ring.size)
        ring.physicsBody?.usesPreciseCollisionDetection = true
        //ring.physicsBody?.categoryBitMask = ringCategory
        //ring.physicsBody?.collisionBitMask = playerCategory | ringCategory
        //ring.physicsBody?.contactTestBitMask = playerCategory | ringCategory
    }
    
    func createPlayer() {
        player.position = CGPointMake(self.size.width/12, self.size.height/6)
        player.name = "johnCena"
        player.size = CGSize(width: 50, height: 50)
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = playerCategory
        self.addChild(player)
    }
    
////    func createRing() {
//        ring.position = CGPointMake(((10*self.size.width)/12),(self.size.height/6))
//        ring.size = CGSize(width: 200, height: 200)
//        ring.physicsBody = SKPhysicsBody(rectangleOfSize: ring.size)
//        ring.physicsBody?.usesPreciseCollisionDetection = true
//        ring.physicsBody?.categoryBitMask = ringCategory
//        ring.physicsBody?.collisionBitMask = playerCategory | ringCategory
//        ring.physicsBody?.contactTestBitMask = playerCategory | ringCategory
//        //return ring
//        addChild(ring)
//    }
    func updateEdgeLoop() {
        let rect = CGRect(origin: CGPointZero, size: self.size)
        let loopBody = SKPhysicsBody(edgeLoopFromRect: rect)
        self.physicsBody = loopBody
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            
//            player.position.y = location.y
//            
//        }
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        if player.frame.contains(location) {
            touchPoint = location
            touching = true
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
//        for touch in (touches as! Set<UITouch>) {
//            let location = touch.locationInNode(self)
//            player.position.y = location.y
//        }
        let touch = touches.first as! UITouch
        let location = touch.locationInNode(self)
        touchPoint = location
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        touching = false
    }
   
    override func update(currentTime: CFTimeInterval) {
        if touching {
            let dt:CGFloat = 1.0/60.0
            let distance = CGVector(dx: touchPoint.x-player.position.x, dy: touchPoint.y-player.position.y)
            let velocity = CGVector(dx: distance.dx/dt, dy: distance.dy/dt)
            player.physicsBody!.velocity=velocity
        }
    }
    
   
}
