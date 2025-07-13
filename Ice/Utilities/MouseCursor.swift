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
        do {
            let event = try systemWideMouseLocation()
            return NSPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        } catch {
            Logger.mouseCursor.error("Error getting AppKit mouse location: \(error)")
            return nil
        }
    }

    /// Returns the current mouse location in Core Graphics coordinates.
    ///
    /// This method returns the mouse location in the coordinate system
    /// used by Core Graphics, which has its origin at the top left of
    /// the screen, with the y-axis pointing down.
    static var locationCoreGraphics: CGPoint? {
        do {
            let event = try systemWideMouseLocation()
            return CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y)
        } catch {
            Logger.mouseCursor.error("Error getting Core Graphics mouse location: \(error)")
            return nil
        }
    }

    /// Returns an event containing the system-wide mouse location.
    private static func systemWideMouseLocation() throws -> NSEvent {
        guard let event = NSEvent.mouseLocation(pressedMouseButtons: 0) else {
            throw CocoaError(.featureUnsupported)
        }
        return event
    }

    /// Hides the mouse cursor and increments the hide cursor count.
    static func hide() {
        let result = CGDisplayHideCursor(CGMainDisplayID())
        if result != .success {
            Logger.mouseCursor.error("CGDisplayHideCursor failed with error \(result.logString)")
        }
    }

    /// Decrements the hide cursor count and shows the mouse cursor if the count is `0`.
    static func show() {
        let result = CGDisplayShowCursor(CGMainDisplayID())
        if result != .success {
            Logger.mouseCursor.error("CGDisplayShowCursor failed with error \(result.logString)")
        }
    }

    /// Moves the mouse cursor to the given point without generating events.
    ///
    /// - Parameter point: The point to move the cursor to in global display coordinates.
    static func warp(to point: CGPoint) {
        let result = CGWarpMouseCursorPosition(point)
        if result != .success {
            Logger.mouseCursor.error("CGWarpMouseCursorPosition failed with error \(result.logString)")
        }
    }
}

// MARK: - Logger
private extension Logger {
    static let mouseCursor = Logger(category: "MouseCursor")
}
