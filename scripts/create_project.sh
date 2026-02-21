#!/bin/bash
# Usage: ./create_project.sh <AppName> <BundleIdPrefix> <DeploymentTarget> [GitHubUser]
# Example: ./create_project.sh Finlogue com.burak 17.0 burakdesign

set -e

APP_NAME="${1:?Usage: $0 <AppName> <BundleIdPrefix> <DeploymentTarget> [GitHubUser]}"
BUNDLE_PREFIX="${2:?Missing bundle ID prefix}"
DEPLOY_TARGET="${3:-17.0}"
GITHUB_USER="${4:-burakdesign}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_DIR="$SKILL_DIR/templates/project"

echo "🚀 Creating project: $APP_NAME"
echo "   Bundle: $BUNDLE_PREFIX.$APP_NAME"
echo "   Target: iOS $DEPLOY_TARGET"

# Create folder structure
mkdir -p "$APP_NAME/$APP_NAME"/{Root/CoreRIB,Modules/{Splash,Onboarding},Core/Onboarding/Service,Components/{Views,ViewModifiers,Modals,Buttons,Images},Design,Extensions,Utilities}

# Function to replace placeholders
replace_placeholders() {
    sed \
        -e "s/__AppName__/$APP_NAME/g" \
        -e "s/__BundleIdPrefix__/$BUNDLE_PREFIX/g" \
        -e "s/__DeploymentTarget__/$DEPLOY_TARGET/g" \
        -e "s/__GitHubUser__/$GITHUB_USER/g" \
        "$1"
}

# Generate root files
replace_placeholders "$TEMPLATE_DIR/__AppName__App.swift" > "$APP_NAME/$APP_NAME/Root/${APP_NAME}App.swift"
replace_placeholders "$TEMPLATE_DIR/AppDelegate.swift" > "$APP_NAME/$APP_NAME/Root/AppDelegate.swift"
replace_placeholders "$TEMPLATE_DIR/CoreBuilder.swift" > "$APP_NAME/$APP_NAME/Root/CoreRIB/CoreBuilder.swift"
replace_placeholders "$TEMPLATE_DIR/CoreInteractor.swift" > "$APP_NAME/$APP_NAME/Root/CoreRIB/CoreInteractor.swift"
replace_placeholders "$TEMPLATE_DIR/CoreRouter.swift" > "$APP_NAME/$APP_NAME/Root/CoreRIB/CoreRouter.swift"
replace_placeholders "$TEMPLATE_DIR/Dependencies.swift" > "$APP_NAME/$APP_NAME/Root/Dependencies.swift"

# Generate Splash module files
replace_placeholders "$TEMPLATE_DIR/Modules/Splash/SplashScreen.swift" > "$APP_NAME/$APP_NAME/Modules/Splash/SplashScreen.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Splash/SplashPresenter.swift" > "$APP_NAME/$APP_NAME/Modules/Splash/SplashPresenter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Splash/SplashInteractor.swift" > "$APP_NAME/$APP_NAME/Modules/Splash/SplashInteractor.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Splash/SplashRouter.swift" > "$APP_NAME/$APP_NAME/Modules/Splash/SplashRouter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Splash/SplashEntity.swift" > "$APP_NAME/$APP_NAME/Modules/Splash/SplashEntity.swift"

# Generate Onboarding module files
replace_placeholders "$TEMPLATE_DIR/Modules/Onboarding/OnboardingScreen.swift" > "$APP_NAME/$APP_NAME/Modules/Onboarding/OnboardingScreen.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Onboarding/OnboardingPresenter.swift" > "$APP_NAME/$APP_NAME/Modules/Onboarding/OnboardingPresenter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Onboarding/OnboardingInteractor.swift" > "$APP_NAME/$APP_NAME/Modules/Onboarding/OnboardingInteractor.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Onboarding/OnboardingRouter.swift" > "$APP_NAME/$APP_NAME/Modules/Onboarding/OnboardingRouter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Onboarding/OnboardingEntity.swift" > "$APP_NAME/$APP_NAME/Modules/Onboarding/OnboardingEntity.swift"

# Generate Onboarding service files
replace_placeholders "$TEMPLATE_DIR/Core/Onboarding/Service/OnboardingServiceProtocol.swift" > "$APP_NAME/$APP_NAME/Core/Onboarding/Service/OnboardingServiceProtocol.swift"
replace_placeholders "$TEMPLATE_DIR/Core/Onboarding/Service/OnboardingService.swift" > "$APP_NAME/$APP_NAME/Core/Onboarding/Service/OnboardingService.swift"
replace_placeholders "$TEMPLATE_DIR/Core/Onboarding/Service/MockOnboardingService.swift" > "$APP_NAME/$APP_NAME/Core/Onboarding/Service/MockOnboardingService.swift"
replace_placeholders "$TEMPLATE_DIR/Core/Onboarding/OnboardingManager.swift" > "$APP_NAME/$APP_NAME/Core/Onboarding/OnboardingManager.swift"

# Generate project.yml
replace_placeholders "$TEMPLATE_DIR/project.yml" > "$APP_NAME/project.yml"

# Generate .gitignore
cp "$TEMPLATE_DIR/.gitignore.template" "$APP_NAME/.gitignore"

# Generate Info.plist
cat > "$APP_NAME/$APP_NAME/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>$(DEVELOPMENT_LANGUAGE)</string>
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>$(PRODUCT_NAME)</string>
    <key>CFBundlePackageType</key>
    <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
    <key>CFBundleShortVersionString</key>
    <string>$(MARKETING_VERSION)</string>
    <key>CFBundleVersion</key>
    <string>$(CURRENT_PROJECT_VERSION)</string>
    <key>UILaunchScreen</key>
    <dict/>
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
    </array>
</dict>
</plist>
EOF

# Design placeholder
cat > "$APP_NAME/$APP_NAME/Design/${APP_NAME}Design.swift" << EOF
//
//  ${APP_NAME}Design.swift
//

import SwiftUI

// TODO: Define app-wide colors and design tokens
struct ${APP_NAME}Design {
    // Example:
    // static let primaryColor = Color.blue
    // static let backgroundColor = Color(.systemBackground)
}
EOF

echo "✅ Project structure created!"

# Try to run xcodegen
if command -v xcodegen &> /dev/null; then
    echo "🔨 Running xcodegen..."
    cd "$APP_NAME" && xcodegen generate
    echo "✅ Xcode project generated!"
    echo "📂 Open with: open $APP_NAME.xcodeproj"
else
    echo "⚠️  xcodegen not found. Install with: brew install xcodegen"
    echo "   Then run: cd $APP_NAME && xcodegen generate"
fi
