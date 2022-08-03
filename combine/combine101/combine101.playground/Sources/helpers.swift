import Foundation

public func example(of description: String,
                    action: () -> Void) {
  print("\n——— Example of:", description, "———")
  action()
}

public class Coordinate {
	public var x: Int
	public var y: Int
	
	public init(_ x: Int, _ y: Int){
		self.x = x
		self.y = y
	}
}
