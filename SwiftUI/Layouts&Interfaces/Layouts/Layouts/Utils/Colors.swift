//
//  Colors.swift
//  Layouts
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
import SwiftUI
import simd

public extension Color {
  /// A random color.
  /// - Parameters:
  ///   - saturation: Normalized. 0...1
  ///   - value: The value of the brightest color channel.
  static func random(
	colorSpace: RGBColorSpace = .displayP3,
	saturation: Double = 1, value: Double = 1,
	opacity: Double = 1
  ) -> Self {
	let channels = SIMD3.randomColor(saturation: saturation, value: value)
	return .init(
	  .displayP3,
	  red: channels[0], green: channels[1], blue: channels[2],
	  opacity: opacity
	)
  }
}

public extension SIMD3 where Scalar == Double {
  /// A random color.
  /// - Parameters:
  ///   - saturation: Normalized. 0...1
  ///   - value: The value of the brightest color channel.
  static func randomColor(saturation: Scalar, value: Scalar) -> Self {
	mix(
	  .init(repeating: value),
	  .init([value, .random(in: 0...value), 0].shuffled()),
	  t: saturation
	)
  }
}
