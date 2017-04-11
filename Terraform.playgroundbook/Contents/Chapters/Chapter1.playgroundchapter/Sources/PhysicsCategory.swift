import Foundation

public struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Player    : UInt32 = 0b1          // 1
    static let World      : UInt32 = 0b10         // 2
    static let Item      : UInt32 = 0b100         // 3
    static let Danger      : UInt32 = 0b1000         // 3
}
