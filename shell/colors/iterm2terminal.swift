#!/usr/bin/xcrun swift
//
// Copyright © 2016 Leon Breedt 
// Ported to Swift 5 by Pablo Morelli 2019
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import Cocoa

/// Enumerates the colors in an iTerm color scheme.
enum iTermColors: String {

    case ansi0 = "Ansi 0 Color"
    case ansi1 = "Ansi 1 Color"
    case ansi2 = "Ansi 2 Color"
    case ansi3 = "Ansi 3 Color"
    case ansi4 = "Ansi 4 Color"
    case ansi5 = "Ansi 5 Color"
    case ansi6 = "Ansi 6 Color"
    case ansi7 = "Ansi 7 Color"
    case ansi8 = "Ansi 8 Color"
    case ansi9 = "Ansi 9 Color"
    case ansi10 = "Ansi 10 Color"
    case ansi11 = "Ansi 11 Color"
    case ansi12 = "Ansi 12 Color"
    case ansi13 = "Ansi 13 Color"
    case ansi14 = "Ansi 14 Color"
    case ansi15 = "Ansi 15 Color"
    case cursorText = "Cursor Text Color"
    case selectedText = "Selected Text Color"
    case foreground = "Foreground Color"
    case background = "Background Color"
    case bold = "Bold Color"
    case selection = "Selection Color"
    case cursor = "Cursor Color"

}

/// Enumerates the colors in a Terminal.app color scheme.
enum TerminalColors: String {

    case ansiBlack           = "ANSIBlackColor"
    case ansiRed             = "ANSIRedColor"
    case ansiGreen           = "ANSIGreenColor"
    case ansiYellow          = "ANSIYellowColor"
    case ansiBlue            = "ANSIBlueColor"
    case ansiMagenta         = "ANSIMagentaColor"
    case ansiCyan            = "ANSICyanColor"
    case ansiWhite           = "ANSIWhiteColor"
    case ansiBrightBlack     = "ANSIBrightBlackColor"
    case ansiBrightRed       = "ANSIBrightRedColor"
    case ansiBrightGreen     = "ANSIBrightGreenColor"
    case ansiBrightYellow    = "ANSIBrightYellowColor"
    case ansiBrightBlue      = "ANSIBrightBlueColor"
    case ansiBrightMagenta   = "ANSIBrightMagentaColor"
    case ansiBrightCyan      = "ANSIBrightCyanColor"
    case ansiBrightWhite     = "ANSIBrightWhiteColor"
    case background          = "BackgroundColor"
    case text                = "TextColor"
    case boldText            = "BoldTextColor"
    case selection           = "SelectionColor"
    case cursor              = "CursorColor"

}

// Mapping of iTerm colors onto corresponding Terminal.app colors.
let iTermColor2TerminalColor = [
    iTermColors.ansi0: TerminalColors.ansiBlack,
    iTermColors.ansi1: TerminalColors.ansiRed,
    iTermColors.ansi2: TerminalColors.ansiGreen,
    iTermColors.ansi3: TerminalColors.ansiYellow,
    iTermColors.ansi4: TerminalColors.ansiBlue,
    iTermColors.ansi5: TerminalColors.ansiMagenta,
    iTermColors.ansi6: TerminalColors.ansiCyan,
    iTermColors.ansi7: TerminalColors.ansiWhite,
    iTermColors.ansi8: TerminalColors.ansiBrightBlack,
    iTermColors.ansi9: TerminalColors.ansiBrightRed,
    iTermColors.ansi10: TerminalColors.ansiBrightGreen,
    iTermColors.ansi11: TerminalColors.ansiBrightYellow,
    iTermColors.ansi12: TerminalColors.ansiBrightBlue,
    iTermColors.ansi13: TerminalColors.ansiBrightMagenta,
    iTermColors.ansi14: TerminalColors.ansiBrightCyan,
    iTermColors.ansi15: TerminalColors.ansiBrightWhite,
    iTermColors.background: TerminalColors.background,
    iTermColors.foreground: TerminalColors.text,
    iTermColors.selection: TerminalColors.selection,
    iTermColors.bold: TerminalColors.boldText,
    iTermColors.cursor: TerminalColors.cursor,
]

/// Enumerates the names of iTerm color components in the scheme dictionary.
struct iTermColorComponent {

    static let red = "Red Component"
    static let green = "Green Component"
    static let blue = "Blue Component"

}

/// Converts an iTerm color scheme file (.itermcolors), into a Terminal.app color scheme
/// file (.terminal).
func convertToTerminalColors(itermFile: String, terminalFile: String) {
    if let itermScheme = NSDictionary(contentsOfFile: itermFile) {
        print("converting \(itermFile) -> \(terminalFile)")
        let name = terminalFile.ns.lastPathComponent.ns.deletingPathExtension
        let terminalScheme = convert(iTermColorScheme: itermScheme, toTerminalSchemeWithName: name)
        terminalScheme.write(toFile: terminalFile, atomically: true)
    } else {
        print("unable to load \(itermFile)")
    }
}

/// Converts an iTerm color scheme dictionary into a Terminal.app color scheme dictionary.
func convert(iTermColorScheme: NSDictionary, toTerminalSchemeWithName name: String) -> NSDictionary {
    var terminalColorScheme: [String: Any] = [
        "name" : name,
        "type" : "Window Settings",
        "ProfileCurrentVersion" : 2.04,
        "columnCount": 90,
        "rowCount": 50
    ]

    // SF Mono is pretty sweet.
    if let font = archivedFontWithName(name: "SF Mono Regular", size: 13) {
        terminalColorScheme["Font"] = font
    }

    for (rawKey, rawValue) in iTermColorScheme {
        guard let name = rawKey as? String else { continue }
        guard let itermDict = rawValue as? NSDictionary else { continue }
        guard let itermKey = iTermColors(rawValue: name) else { continue }
        guard let terminalKey = iTermColor2TerminalColor[itermKey] else { continue }

        let (r, g, b) = (
            (itermDict[iTermColorComponent.red] as? CGFloat) ?? CGFloat(0),
            (itermDict[iTermColorComponent.green] as? CGFloat) ?? CGFloat(0),
            (itermDict[iTermColorComponent.blue] as? CGFloat) ?? CGFloat(0)
        )

        let color = NSColor(deviceRed: r, green: g, blue: b, alpha: 1)
        let data = try! NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)

        terminalColorScheme[terminalKey.rawValue] = data
    }

    return terminalColorScheme as NSDictionary
}

/// Creates an `NSData` representation of an `NSFont`.
func archivedFontWithName(name: String, size: CGFloat) -> Data? {
    if let font = NSFont(name: name, size: size) {
        return try! NSKeyedArchiver.archivedData(withRootObject: font, requiringSecureCoding: true)
    }
    return nil
}

extension String {

    /// Gets the canonical version of a path.
    var fullPath: String {
        get {
            let path = ns.standardizingPath
            var directory = ns.deletingLastPathComponent
            if directory.utf8.count == 0 {
                directory = FileManager.default.currentDirectoryPath
            }
            return directory.ns.appendingPathComponent(path)
        }
    }

    /// Convenience property for accessing this string as an `NSString`.
    var ns: NSString {
        return self as NSString
    }

}

// Entry point.
let args = CommandLine.arguments.dropFirst()
if args.count > 0 {
    for itermFile in args {
        let path = itermFile.fullPath
        let folder = path.ns.deletingLastPathComponent
        let schemeName = path.ns.lastPathComponent.ns.deletingPathExtension
        let terminalPath = "\(folder)/\(schemeName).terminal"
        convertToTerminalColors(itermFile: path, terminalFile: terminalPath)
    }
} else {
    print("usage: iTermColorsToTerminalColors FILE.itermcolors [...]")
}
