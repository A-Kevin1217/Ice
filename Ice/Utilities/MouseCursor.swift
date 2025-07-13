//
//  MouseCursor.swift
//  Ice
//

import Cocoa

/// A namespace for mouse cursor operations.
enum MouseCursor {
    /// Returns the current mouse location in AppKit coordinates.
    ///
    /// This method returns the mouse location in the coordinate system
    /// used by AppKit, which has its origin at the bottom left of the
    /// screen, with the y-axis pointing up.
    static var locationAppKit: NSPoint? {
        NSEvent.mouseLocation
    }

    /// Returns the current mouse location in Core Graphics coordinates.
    ///
    /// This method returns the mouse location in the coordinate system
    /// used by Core Graphics, which has its origin at the top left of
    /// the screen, with the y-axis pointing down.
    static var locationCoreGraphics: CGPoint? {
        guard let location = locationAppKit else {
            return nil
        }
        guard let screen = NSScreen.screens.first(where: { $0.frame.contains(location) }) else {
            return nil
        }
        return CGPoint(x: location.x, y: screen.frame.maxY - location.y)
    }
}
