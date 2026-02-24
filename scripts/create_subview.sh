#!/bin/bash
# Usage: ./create_subview.sh <scoped|common> <ViewName> [ScopeName] [ProjectSourceDir]
# Example: ./create_subview.sh scoped CouponInputView PaymentScreen
# Example: ./create_subview.sh common SharedInputView

set -e

TYPE="${1:?Usage: $0 <scoped|common> <ViewName> [ScopeName] [ProjectSourceDir]}"
VIEW_NAME="${2:?Missing view name}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_DIR="$SKILL_DIR/templates/subview"

# Header variables
USERNAME=$(git config user.name 2>/dev/null || whoami)
CURRENT_DATE=$(date "+%-m/%-d/%y")

if [ "$TYPE" = "scoped" ]; then
    SCOPE_NAME="${3:?Scoped subview requires ScopeName (parent screen name)}"
    SOURCE_DIR="${4:-.}"
    SRC="$TEMPLATE_DIR/scoped"

    MODULE_DIR=$(find "$SOURCE_DIR" -maxdepth 5 -type d -name "Modules" | head -1)
    if [ -z "$MODULE_DIR" ]; then
        echo "❌ Could not find Modules/ directory"
        exit 1
    fi

    SCOPE_DIR=$(find "$MODULE_DIR" -maxdepth 2 -type d -name "$SCOPE_NAME" | head -1)
    if [ -z "$SCOPE_DIR" ]; then
        echo "❌ Could not find module: $SCOPE_NAME in $MODULE_DIR"
        exit 1
    fi

    SUBVIEW_DIR="$SCOPE_DIR/Subviews/$VIEW_NAME"
    echo "📦 Creating scoped subview: $VIEW_NAME (scope: ${SCOPE_NAME}Screen)"
    echo "   Location: $SUBVIEW_DIR"
    echo "   Author: $USERNAME | $CURRENT_DATE"

    # Flat structure — no Entity/ subfolder
    mkdir -p "$SUBVIEW_DIR"

    sed -e "s|__ViewName__|$VIEW_NAME|g" \
        -e "s|__ScopeName__|${SCOPE_NAME}Screen|g" \
        -e "s|__Username__|$USERNAME|g" \
        -e "s|__Date__|$CURRENT_DATE|g" \
        "$SRC/__ViewName__.swift" > "$SUBVIEW_DIR/${VIEW_NAME}.swift"

    sed -e "s|__ViewName__|$VIEW_NAME|g" \
        -e "s|__ScopeName__|${SCOPE_NAME}Screen|g" \
        -e "s|__Username__|$USERNAME|g" \
        -e "s|__Date__|$CURRENT_DATE|g" \
        "$SRC/__ViewName__Entity.swift" > "$SUBVIEW_DIR/${VIEW_NAME}Entity.swift"

    sed -e "s|__ViewName__|$VIEW_NAME|g" \
        -e "s|__ScopeName__|${SCOPE_NAME}Screen|g" \
        -e "s|__Username__|$USERNAME|g" \
        -e "s|__Date__|$CURRENT_DATE|g" \
        "$SRC/__ViewName__Binding.swift" > "$SUBVIEW_DIR/${VIEW_NAME}Binding.swift"

    sed -e "s|__ViewName__|$VIEW_NAME|g" \
        -e "s|__ScopeName__|${SCOPE_NAME}Screen|g" \
        -e "s|__Username__|$USERNAME|g" \
        -e "s|__Date__|$CURRENT_DATE|g" \
        "$SRC/__ViewName__Config.swift" > "$SUBVIEW_DIR/${VIEW_NAME}Config.swift"

    echo "✅ Scoped subview created: $VIEW_NAME"
    echo ""
    echo "📝 Update ${SCOPE_NAME}Presenter.swift — Add entity + action handler"

elif [ "$TYPE" = "common" ]; then
    SOURCE_DIR="${3:-.}"
    SRC="$TEMPLATE_DIR/common"

    COMP_DIR=$(find "$SOURCE_DIR" -maxdepth 5 -type d -name "Views" | grep -i "Components" | head -1)
    if [ -z "$COMP_DIR" ]; then
        echo "❌ Could not find Components/Views/ directory"
        exit 1
    fi

    SUBVIEW_DIR="$COMP_DIR/$VIEW_NAME"
    echo "📦 Creating common subview: $VIEW_NAME"
    echo "   Location: $SUBVIEW_DIR"
    echo "   Author: $USERNAME | $CURRENT_DATE"

    # Flat structure — no Entity/ subfolder
    mkdir -p "$SUBVIEW_DIR"

    sed -e "s|__ViewName__|$VIEW_NAME|g" \
        -e "s|__Username__|$USERNAME|g" \
        -e "s|__Date__|$CURRENT_DATE|g" \
        "$SRC/__ViewName__.swift" > "$SUBVIEW_DIR/${VIEW_NAME}.swift"

    sed -e "s|__ViewName__|$VIEW_NAME|g" \
        -e "s|__Username__|$USERNAME|g" \
        -e "s|__Date__|$CURRENT_DATE|g" \
        "$SRC/__ViewName__Entity.swift" > "$SUBVIEW_DIR/${VIEW_NAME}Entity.swift"

    sed -e "s|__ViewName__|$VIEW_NAME|g" \
        -e "s|__Username__|$USERNAME|g" \
        -e "s|__Date__|$CURRENT_DATE|g" \
        "$SRC/__ViewName__Binding.swift" > "$SUBVIEW_DIR/${VIEW_NAME}Binding.swift"

    sed -e "s|__ViewName__|$VIEW_NAME|g" \
        -e "s|__Username__|$USERNAME|g" \
        -e "s|__Date__|$CURRENT_DATE|g" \
        "$SRC/__ViewName__Config.swift" > "$SUBVIEW_DIR/${VIEW_NAME}Config.swift"

    echo "✅ Common subview created: $VIEW_NAME"
else
    echo "❌ Unknown type: $TYPE (use 'scoped' or 'common')"
    exit 1
fi
