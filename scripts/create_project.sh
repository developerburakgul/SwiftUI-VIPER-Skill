#!/bin/bash
# Usage: ./create_project.sh <AppName> <BundleIdPrefix> <DeploymentTarget> [GitHubUser]
# Example: ./create_project.sh Finlogue com.burak 16.0 burakdesign

set -e

APP_NAME="${1:?Usage: $0 <AppName> <BundleIdPrefix> <DeploymentTarget> [GitHubUser]}"
BUNDLE_PREFIX="${2:?Missing bundle ID prefix}"
DEPLOY_TARGET="${3:-16.0}"
GITHUB_USER="${4:-burakdesign}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_DIR="$SKILL_DIR/templates/project"

# Kullanıcı adı ve tarih bilgisi
CURRENT_USER="$(id -F 2>/dev/null || whoami)"
CURRENT_DATE="$(date '+%-m/%-d/%y')"

echo "🚀 Creating project: $APP_NAME"
echo "   Bundle: $BUNDLE_PREFIX.$APP_NAME"
echo "   Target: iOS $DEPLOY_TARGET"

# Create folder structure
mkdir -p "$APP_NAME/$APP_NAME"/{Root/CoreRIB,Modules/{Splash,Onboarding,Tabbar,Home,Favorites,Settings},Core/User/Service,Components/{Views,ViewModifiers,Modals,Buttons,Images},Design,Extensions,Utilities}
mkdir -p "$APP_NAME/$APP_NAME"/Modules/{Splash,Onboarding,Tabbar,Home,Favorites,Settings}/Subviews
for MODULE in Splash Onboarding Tabbar Home Favorites Settings; do
    touch "$APP_NAME/$APP_NAME/Modules/$MODULE/Subviews/.gitkeep"
done

# Function to replace placeholders
replace_placeholders() {
    sed \
        -e "s/__AppName__/$APP_NAME/g" \
        -e "s/__BundleIdPrefix__/$BUNDLE_PREFIX/g" \
        -e "s/__DeploymentTarget__/$DEPLOY_TARGET/g" \
        -e "s/__GitHubUser__/$GITHUB_USER/g" \
        -e "s/__Username__/$CURRENT_USER/g" \
        -e "s/__Date__/$CURRENT_DATE/g" \
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

# Generate Tabbar module files
replace_placeholders "$TEMPLATE_DIR/Modules/Tabbar/TabbarScreen.swift" > "$APP_NAME/$APP_NAME/Modules/Tabbar/TabbarScreen.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Tabbar/TabbarPresenter.swift" > "$APP_NAME/$APP_NAME/Modules/Tabbar/TabbarPresenter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Tabbar/TabbarInteractor.swift" > "$APP_NAME/$APP_NAME/Modules/Tabbar/TabbarInteractor.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Tabbar/TabbarRouter.swift" > "$APP_NAME/$APP_NAME/Modules/Tabbar/TabbarRouter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Tabbar/TabbarEntity.swift" > "$APP_NAME/$APP_NAME/Modules/Tabbar/TabbarEntity.swift"

# Generate Home module files
replace_placeholders "$TEMPLATE_DIR/Modules/Home/HomeScreen.swift" > "$APP_NAME/$APP_NAME/Modules/Home/HomeScreen.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Home/HomePresenter.swift" > "$APP_NAME/$APP_NAME/Modules/Home/HomePresenter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Home/HomeInteractor.swift" > "$APP_NAME/$APP_NAME/Modules/Home/HomeInteractor.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Home/HomeRouter.swift" > "$APP_NAME/$APP_NAME/Modules/Home/HomeRouter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Home/HomeEntity.swift" > "$APP_NAME/$APP_NAME/Modules/Home/HomeEntity.swift"

# Generate Favorites module files
replace_placeholders "$TEMPLATE_DIR/Modules/Favorites/FavoritesScreen.swift" > "$APP_NAME/$APP_NAME/Modules/Favorites/FavoritesScreen.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Favorites/FavoritesPresenter.swift" > "$APP_NAME/$APP_NAME/Modules/Favorites/FavoritesPresenter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Favorites/FavoritesInteractor.swift" > "$APP_NAME/$APP_NAME/Modules/Favorites/FavoritesInteractor.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Favorites/FavoritesRouter.swift" > "$APP_NAME/$APP_NAME/Modules/Favorites/FavoritesRouter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Favorites/FavoritesEntity.swift" > "$APP_NAME/$APP_NAME/Modules/Favorites/FavoritesEntity.swift"

# Generate Settings module files
replace_placeholders "$TEMPLATE_DIR/Modules/Settings/SettingsScreen.swift" > "$APP_NAME/$APP_NAME/Modules/Settings/SettingsScreen.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Settings/SettingsPresenter.swift" > "$APP_NAME/$APP_NAME/Modules/Settings/SettingsPresenter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Settings/SettingsInteractor.swift" > "$APP_NAME/$APP_NAME/Modules/Settings/SettingsInteractor.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Settings/SettingsRouter.swift" > "$APP_NAME/$APP_NAME/Modules/Settings/SettingsRouter.swift"
replace_placeholders "$TEMPLATE_DIR/Modules/Settings/SettingsEntity.swift" > "$APP_NAME/$APP_NAME/Modules/Settings/SettingsEntity.swift"

# Generate User service files
replace_placeholders "$TEMPLATE_DIR/Core/User/Service/UserServiceProtocol.swift" > "$APP_NAME/$APP_NAME/Core/User/Service/UserServiceProtocol.swift"
replace_placeholders "$TEMPLATE_DIR/Core/User/Service/UserService.swift" > "$APP_NAME/$APP_NAME/Core/User/Service/UserService.swift"
replace_placeholders "$TEMPLATE_DIR/Core/User/Service/MockUserService.swift" > "$APP_NAME/$APP_NAME/Core/User/Service/MockUserService.swift"
replace_placeholders "$TEMPLATE_DIR/Core/User/UserManager.swift" > "$APP_NAME/$APP_NAME/Core/User/UserManager.swift"

# Generate project.yml
replace_placeholders "$TEMPLATE_DIR/project.yml" > "$APP_NAME/project.yml"

# Generate .gitignore
cp "$TEMPLATE_DIR/.gitignore.template" "$APP_NAME/.gitignore"

# Generate Info.plist
cp "$TEMPLATE_DIR/Info.plist" "$APP_NAME/$APP_NAME/Info.plist"

# Design dosyası
replace_placeholders "$TEMPLATE_DIR/Design/__AppName__Design.swift" > "$APP_NAME/$APP_NAME/Design/${APP_NAME}Design.swift"

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
