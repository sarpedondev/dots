#!/usr/bin/env bash
# Bumps overlays/rea-agents.nix to the latest npm release of rea-agents.
set -euo pipefail

cd "$(dirname "$0")"
file=overlays/rea-agents.nix

meta=$(curl -fsSL https://registry.npmjs.org/rea-agents/latest)
version=$(jq -r .version <<<"$meta")
current=$(sed -n 's/^  version = "\(.*\)";/\1/p' "$file")

if [[ "$version" == "$current" ]]; then
  echo "rea-agents ist aktuell ($current)"
  exit 0
fi
echo "rea-agents: $current -> $version"

# npm publishes an SRI hash, usable directly by fetchurl
src_hash=$(jq -r .dist.integrity <<<"$meta")

lock_url="https://raw.githubusercontent.com/morluto/rea/rea-agents-${version}/package-lock.json"
lock_hash=$(nix store prefetch-file --json "$lock_url" | jq -r .hash)

sed -i \
  -e "s|^  version = \".*\";|  version = \"${version}\";|" \
  -e "s|url = \"https://raw.githubusercontent.com/morluto/rea/[^/]*/package-lock.json\";|url = \"${lock_url}\";|" \
  "$file"

# Replace the hash on the line following each url
sed -i \
  -e "/package-lock.json\";/{n;s|hash = \".*\";|hash = \"${lock_hash}\";|}" \
  -e "/rea-agents-\${version}.tgz\";/{n;s|hash = \".*\";|hash = \"${src_hash}\";|}" \
  "$file"

# Derive npmDepsHash from the hash mismatch of a fake-hash build
sed -i 's|npmDepsHash = ".*";|npmDepsHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";|' "$file"
expr="let pkgs = import (builtins.getFlake (toString ./.)).inputs.nixpkgs { }; in (pkgs.callPackage ./${file} { }).npmDeps"
deps_hash=$(nix build --impure --no-link --expr "$expr" 2>&1 | sed -n 's/.*got: *\(sha256-[^ ]*\).*/\1/p' || true)

if [[ -z "$deps_hash" ]]; then
  echo "npmDepsHash konnte nicht ermittelt werden" >&2
  exit 1
fi
sed -i "s|npmDepsHash = \".*\";|npmDepsHash = \"${deps_hash}\";|" "$file"

echo "fertig: rea-agents ${version}"
