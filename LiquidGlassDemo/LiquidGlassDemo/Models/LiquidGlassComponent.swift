//
//  LiquidGlassComponent.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/16.
//

import UIKit

enum LiquidGlassComponent: Int, CaseIterable {
    case navigationBar
    case tabBar
    case toolbar
    case searchBar
    case alertAndActionSheet
    case glassButton
    case prominentGlassButton
    case glassEffectBasic
    case glassEffectTinted
    case glassContainerMorphing
    case cornerConfiguration
    case segmentedControl
    case slider
    case switchControl
    case datePicker
    case progressView
    case glassCardView
    case animatedGlass
    case sfSymbolsOnGlass
    case tintedInteractiveButtons

    var title: String {
        switch self {
        case .navigationBar: return "Navigation Bar"
        case .tabBar: return "Tab Bar"
        case .toolbar: return "Toolbar"
        case .searchBar: return "Search Bar"
        case .alertAndActionSheet: return "Alert & Action Sheet"
        case .glassButton: return "Glass Button"
        case .prominentGlassButton: return "Prominent Glass Button"
        case .glassEffectBasic: return "Glass Effect (Basic)"
        case .glassEffectTinted: return "Glass Effect (Tinted)"
        case .glassContainerMorphing: return "Glass Container (Morphing)"
        case .cornerConfiguration: return "Corner Configuration"
        case .segmentedControl: return "Segmented Control"
        case .slider: return "Slider"
        case .switchControl: return "Switch"
        case .datePicker: return "Date Picker"
        case .progressView: return "Progress View"
        case .glassCardView: return "Glass Card View"
        case .animatedGlass: return "Animated Glass"
        case .sfSymbolsOnGlass: return "SF Symbols on Glass"
        case .tintedInteractiveButtons: return "Tinted Interactive Buttons"
        }
    }

    var subtitle: String {
        switch self {
        case .navigationBar: return "Auto-adopted glass navigation bar with bar button items"
        case .tabBar: return "Auto-adopted glass tab bar with minimize behavior"
        case .toolbar: return "Auto-adopted glass toolbar with shared background"
        case .searchBar: return "Auto-adopted glass search bar"
        case .alertAndActionSheet: return "Glass-styled alerts and action sheets"
        case .glassButton: return "UIButton with .glass() configuration"
        case .prominentGlassButton: return "UIButton with .prominentGlass() configuration"
        case .glassEffectBasic: return "UIVisualEffectView + UIGlassEffect"
        case .glassEffectTinted: return "UIGlassEffect with color tinting"
        case .glassContainerMorphing: return "UIGlassContainerEffect with morphing animation"
        case .cornerConfiguration: return "Capsule, circle, and rounded rect corners"
        case .segmentedControl: return "UISegmentedControl with glass styling"
        case .slider: return "UISlider with enhanced features"
        case .switchControl: return "UISwitch with updated glass appearance"
        case .datePicker: return "UIDatePicker with multiple styles"
        case .progressView: return "UIProgressView with animated progress"
        case .glassCardView: return "Custom reusable glass card component"
        case .animatedGlass: return "Materialize and dematerialize glass animation"
        case .sfSymbolsOnGlass: return "SF Symbol icons on glass circles"
        case .tintedInteractiveButtons: return "Color-coded glass buttons with tap feedback"
        }
    }

    var iconName: String {
        switch self {
        case .navigationBar: return "rectangle.topthird.inset.filled"
        case .tabBar: return "dock.rectangle"
        case .toolbar: return "rectangle.bottomthird.inset.filled"
        case .searchBar: return "magnifyingglass"
        case .alertAndActionSheet: return "exclamationmark.triangle"
        case .glassButton: return "button.horizontal"
        case .prominentGlassButton: return "button.horizontal.fill"
        case .glassEffectBasic: return "square.on.square"
        case .glassEffectTinted: return "paintpalette"
        case .glassContainerMorphing: return "rectangle.3.group"
        case .cornerConfiguration: return "square.and.pencil"
        case .segmentedControl: return "rectangle.split.3x1"
        case .slider: return "slider.horizontal.3"
        case .switchControl: return "switch.2"
        case .datePicker: return "calendar"
        case .progressView: return "chart.bar.fill"
        case .glassCardView: return "rectangle.on.rectangle"
        case .animatedGlass: return "wand.and.stars"
        case .sfSymbolsOnGlass: return "star.circle"
        case .tintedInteractiveButtons: return "circle.grid.2x2.fill"
        }
    }
}
