#!/bin/bash
# Usage: ./create_subview.sh <scoped|common> <ViewName> [ScopeName] [ProjectSourceDir]
# Example: ./create_subview.sh scoped CouponInputView PaymentScreen
# Example: ./create_subview.sh common SharedInputView

set -e

TYPE="${1:?Usage: $0 <scoped|common> <ViewName> [ScopeName] [ProjectSourceDir]}"
VIEW_NAME="${2:?Missing view name}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"

replace_view() {
    local scope="$1"
    sed \
        -e "s/__ViewName__/$VIEW_NAME/g" \
        -e "s/__ScopeName__/$scope/g" \
        "$2"
}

if [ "$TYPE" = "scoped" ]; then
    SCOPE_NAME="${3:?Scoped subview requires ScopeName (parent screen)}"
    SOURCE_DIR="${4:-.}"
    TEMPLATE_DIR="$SKILL_DIR/templates/subview/scoped"

    # Find module directory
    MODULE_DIR=$(find "$SOURCE_DIR" -maxdepth 4 -type d -name "$SCOPE_NAME" | grep "Modules" | head -1)
    if [ -z "$MODULE_DIR" ]; then
        # Try without Screen suffix
        SCOPE_SEARCH="${SCOPE_NAME%Screen}"
        MODULE_DIR=$(find "$SOURCE_DIR" -maxdepth 4 -type d -name "$SCOPE_SEARCH" | grep "Modules" | head -1)
    fi
    if [ -z "$MODULE_DIR" ]; then
        echo "❌ Could not find module: $SCOPE_NAME"
        exit 1
    fi

    SUBVIEW_DIR="$MODULE_DIR/Subviews/$VIEW_NAME"
    echo "📦 Creating scoped subview: $VIEW_NAME (scope: $SCOPE_NAME)"
    echo "   Location: $SUBVIEW_DIR"

    mkdir -p "$SUBVIEW_DIR/Entity"

    # Use ScopeNameScreen format for extension
    SCOPE_STRUCT="${SCOPE_NAME}Screen"

    replace_view "$SCOPE_STRUCT" "$TEMPLATE_DIR/__ViewName__.swift" > "$SUBVIEW_DIR/${VIEW_NAME}.swift"
    replace_view "$SCOPE_STRUCT" "$TEMPLATE_DIR/__ViewName__Entity.swift" > "$SUBVIEW_DIR/Entity/${VIEW_NAME}Entity.swift"
    replace_view "$SCOPE_STRUCT" "$TEMPLATE_DIR/__ViewName__Binding.swift" > "$SUBVIEW_DIR/Entity/${VIEW_NAME}Binding.swift"
    replace_view "$SCOPE_STRUCT" "$TEMPLATE_DIR/__ViewName__Config.swift" > "$SUBVIEW_DIR/Entity/${VIEW_NAME}Config.swift"

    echo "✅ Scoped subview created: $VIEW_NAME"
    echo ""
    echo "📝 Update ${SCOPE_NAME}Presenter.swift:"
    echo "   var ${VIEW_NAME,,}Entity = ${SCOPE_STRUCT}.${VIEW_NAME}Entity("
    echo "       binding: .init(),"
    echo "       config: .init()"
    echo "   )"

elif [ "$TYPE" = "common" ]; then
    SOURCE_DIR="${3:-.}"
    TEMPLATE_DIR="$SKILL_DIR/templates/subview/common"

    # Find Components/Views directory
    COMP_DIR=$(find "$SOURCE_DIR" -maxdepth 4 -type d -name "Views" | grep "Components" | head -1)
    if [ -z "$COMP_DIR" ]; then
        echo "❌ Could not find Components/Views/ directory"
        exit 1
    fi

    SUBVIEW_DIR="$COMP_DIR/$VIEW_NAME"
    echo "📦 Creating common subview: $VIEW_NAME"
    echo "   Location: $SUBVIEW_DIR"

    mkdir -p "$SUBVIEW_DIR/Entity"

    replace_view "" "$TEMPLATE_DIR/__ViewName__.swift" > "$SUBVIEW_DIR/${VIEW_NAME}.swift"
    replace_view "" "$TEMPLATE_DIR/__ViewName__Entity.swift" > "$SUBVIEW_DIR/Entity/${VIEW_NAME}Entity.swift"
    replace_view "" "$TEMPLATE_DIR/__ViewName__Binding.swift" > "$SUBVIEW_DIR/Entity/${VIEW_NAME}Binding.swift"
    replace_view "" "$TEMPLATE_DIR/__ViewName__Config.swift" > "$SUBVIEW_DIR/Entity/${VIEW_NAME}Config.swift"

    echo "✅ Common subview created: $VIEW_NAME"
else
    echo "❌ Unknown type: $TYPE (use 'scoped' or 'common')"
    exit 1
fi
