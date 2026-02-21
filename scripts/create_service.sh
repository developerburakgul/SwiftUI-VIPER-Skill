#!/bin/bash
# Usage: ./create_service.sh <DomainName> [ProjectSourceDir]
# Example: ./create_service.sh Auth ./Finlogue/Finlogue
# Example: ./create_service.sh Receipt

set -e

DOMAIN_NAME="${1:?Usage: $0 <DomainName> [ProjectSourceDir]}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATE_DIR="$SKILL_DIR/templates/service"

# Auto-detect source directory
if [ -n "$2" ]; then
    SOURCE_DIR="$2"
else
    SOURCE_DIR=$(find . -maxdepth 3 -type d -name "Core" | head -1)
    if [ -z "$SOURCE_DIR" ]; then
        echo "❌ Could not find Core/ directory. Specify path manually."
        exit 1
    fi
    SOURCE_DIR="$(dirname "$SOURCE_DIR")"
fi

SERVICE_DIR="$SOURCE_DIR/Core/$DOMAIN_NAME"

echo "📦 Creating service domain: $DOMAIN_NAME"
echo "   Location: $SERVICE_DIR"

# Create directory structure
mkdir -p "$SERVICE_DIR"/{Models,Service}

# Function to replace placeholders
replace_domain() {
    sed -e "s/__DomainName__/$DOMAIN_NAME/g" "$1"
}

# Generate files
replace_domain "$TEMPLATE_DIR/__DomainName__Manager.swift" > "$SERVICE_DIR/${DOMAIN_NAME}Manager.swift"
replace_domain "$TEMPLATE_DIR/__DomainName__ServiceProtocol.swift" > "$SERVICE_DIR/Service/${DOMAIN_NAME}ServiceProtocol.swift"
replace_domain "$TEMPLATE_DIR/Mock__DomainName__Service.swift" > "$SERVICE_DIR/Service/Mock${DOMAIN_NAME}Service.swift"

# Create placeholder model
cat > "$SERVICE_DIR/Models/${DOMAIN_NAME}Model.swift" << EOF
//
//  ${DOMAIN_NAME}Model.swift
//

import Foundation

struct ${DOMAIN_NAME}Model: Identifiable, Codable, Hashable {
    let id: String

    // TODO: Add properties

    enum CodingKeys: String, CodingKey {
        case id
    }

    static var mock: Self { mocks[0] }
    static var mocks: [Self] {
        [
            ${DOMAIN_NAME}Model(id: "mock_1"),
            ${DOMAIN_NAME}Model(id: "mock_2"),
        ]
    }
}
EOF

echo "✅ Service domain created: $DOMAIN_NAME"
echo ""
echo "📝 Don't forget to update:"
echo "   1. CoreInteractor.swift — Add manager property:"
echo "      private let ${DOMAIN_NAME,,}Manager: ${DOMAIN_NAME}Manager"
echo "      // In init: self.${DOMAIN_NAME,,}Manager = container.resolve(${DOMAIN_NAME}Manager.self)!"
echo ""
echo "   2. Dependencies.swift — Create and register manager:"
echo "      let ${DOMAIN_NAME,,}Manager = ${DOMAIN_NAME}Manager(service: Mock${DOMAIN_NAME}Service())"
echo "      container.register(${DOMAIN_NAME}Manager.self, service: ${DOMAIN_NAME,,}Manager)"
echo ""
echo "   3. DevPreview — Add mock manager"
