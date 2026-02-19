//
//  LiquidGlassComponent+DemoView.swift
//  LiquidGlassDemo
//
//  Created by Eric Chen on 2026/2/19.
//

import UIKit

extension LiquidGlassComponent {
    func makeDemoView(parentVC: UIViewController) -> UIView {
        switch self {
        case .navigationBar:
            return NavigationBarDemoView(parentVC: parentVC)
        case .tabBar:
            return TabBarDemoView()
        case .toolbar:
            return ToolbarDemoView(parentVC: parentVC)
        case .searchBar:
            return SearchBarDemoView()
        case .alertAndActionSheet:
            return AlertDemoView(parentVC: parentVC)
        case .glassButton:
            return GlassButtonDemoView()
        case .prominentGlassButton:
            return ProminentGlassButtonDemoView()
        case .glassEffectBasic:
            return GlassEffectDemoView()
        case .glassEffectTinted:
            return TintedGlassDemoView()
        case .glassContainerMorphing:
            return GlassContainerDemoView()
        case .cornerConfiguration:
            return CornerConfigDemoView()
        case .segmentedControl:
            return SegmentedControlDemoView()
        case .slider:
            return SliderDemoView()
        case .switchControl:
            return SwitchDemoView()
        case .datePicker:
            return DatePickerDemoView()
        case .progressView:
            return ProgressViewDemoView()
        case .glassCardView:
            return GlassCardDemoView()
        case .animatedGlass:
            return AnimatedGlassDemoView()
        case .sfSymbolsOnGlass:
            return SFSymbolsDemoView()
        case .tintedInteractiveButtons:
            return TintedInteractiveButtonsDemoView()
        }
    }
}
