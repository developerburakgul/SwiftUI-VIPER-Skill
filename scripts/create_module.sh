#!/bin/bash
# Usage: ./create_module.sh <ModuleName> [ProjectSourceDir]
# Example: ./create_module.sh Settings ./Finlogue/Finlogue
# Example: ./create_module.sh Receipt  (auto-detects source dir)

set -e

MODULE_NAME="${1:?Usage: $0 <ModuleName> [ProjectSourceDir]}"
# Convert first letter to lowercase for method names
MODULE_NAME_LOWER="$(echo "${MODULE_NAME:0:1}" | tr '[:upper:]' '[:lower:]')${MODULE_NAME:1}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_DIR="$SKILL_DIR/templates/module"

# Auto-detect source directory
if [ -n "$2" ]; then
    SOURCE_DIR="$2"
else
    # Look for Modules/ directory in current path
    SOURCE_DIR=$(find . -maxdepth 3 -type d -name "Modules" | head -1)
    if [ -z "$SOURCE_DIR" ]; then
        echo "❌ Could not find Modules/ directory. Specify path manually."
        exit 1
    fi
    SOURCE_DIR="$(dirname "$SOURCE_DIR")"
fi

MODULE_DIR="$SOURCE_DIR/Modules/$MODULE_NAME"

echo "📦 Creating module: $MODULE_NAME"
echo "   Location: $MODULE_DIR"

# Create directory structure
mkdir -p "$MODULE_DIR"/{Entity,Subviews}

# Function to replace placeholders
replace_module() {
    sed \
        -e "s/__ModuleName__/$MODULE_NAME/g" \
        -e "s/__moduleName__/$MODULE_NAME_LOWER/g" \
        "$1"
}

# Generate module files
replace_module "$TEMPLATE_DIR/__ModuleName__Screen.swift" > "$MODULE_DIR/${MODULE_NAME}Screen.swift"
replace_module "$TEMPLATE_DIR/__ModuleName__Presenter.swift" > "$MODULE_DIR/${MODULE_NAME}Presenter.swift"
replace_module "$TEMPLATE_DIR/__ModuleName__Interactor.swift" > "$MODULE_DIR/${MODULE_NAME}Interactor.swift"
replace_module "$TEMPLATE_DIR/__ModuleName__Router.swift" > "$MODULE_DIR/${MODULE_NAME}Router.swift"
replace_module "$TEMPLATE_DIR/__ModuleName__Entity.swift" > "$MODULE_DIR/Entity/${MODULE_NAME}Entity.swift"

echo "✅ Module created: $MODULE_NAME"
echo ""
echo "📝 Don't forget to update:"
echo "   1. CoreBuilder.swift — Add factory method:"
echo "      func ${MODULE_NAME_LOWER}Screen(router: Router, entity: ${MODULE_NAME}Entity = ${MODULE_NAME}Entity()) -> some View {"
echo "          ${MODULE_NAME}Screen("
echo "              presenter: ${MODULE_NAME}Presenter("
echo "                  interactor: interactor,"
echo "                  router: CoreRouter(router: router, builder: self),"
echo "                  entity: entity"
echo "              )"
echo "          )"
echo "      }"
echo ""
echo "   2. CoreRouter.swift — Add navigation method (if needed):"
echo "      func show${MODULE_NAME}Screen(entity: ${MODULE_NAME}Entity = ${MODULE_NAME}Entity()) {"
echo "          router.showScreen(.push) { router in"
echo "              builder.${MODULE_NAME_LOWER}Screen(router: router, entity: entity)"
echo "          }"
echo "      }"
