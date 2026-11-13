#!/usr/bin/env bash
# Updates flake inputs and bumps overlay packages pinned to upstream versions.
set -euo pipefail

cd "$(dirname "$0")"

FAKE_HASH="sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="

# Prints the hash a fixed-output derivation actually produced (from the mismatch error)
got_hash() {
  local expr="let pkgs = import (builtins.getFlake (toString ./.)).inputs.nixpkgs { }; in $1"
  local out
  out=$(nix build --impure --no-link --expr "$expr" 2>&1 | sed -n 's/.*got: *\(sha256-[^ ]*\).*/\1/p' || true)
  if [[ -z "$out" ]]; then
    echo "Could not determine hash for '$1'" >&2
    return 1
  fi
  echo "$out"
}

set_npm_deps_hash() {
  local file=$1
  sed -i "s|npmDepsHash = \".*\";|npmDepsHash = \"${FAKE_HASH}\";|" "$file"
  local hash
  hash=$(got_hash "(pkgs.callPackage ./${file} { }).npmDeps")
  sed -i "s|npmDepsHash = \".*\";|npmDepsHash = \"${hash}\";|" "$file"
}

update_rea() {
  local file=overlays/rea-agents.nix
  local meta version current
  meta=$(curl -fsSL https://registry.npmjs.org/rea-agents/latest)
  version=$(jq -r .version <<<"$meta")
  current=$(sed -n 's/^  version = "\(.*\)";/\1/p' "$file")

  if [[ "$version" == "$current" ]]; then
    echo "rea-agents is up to date ($current)"
    return
  fi
  echo "rea-agents: $current -> $version"

  # npm publishes an SRI hash, usable directly by fetchurl
  local src_hash lock_url lock_hash
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

  set_npm_deps_hash "$file"
}

update_claude() {
  local file=overlays/clawgod.nix
  local meta version current
  meta=$(curl -fsSL https://registry.npmjs.org/@anthropic-ai/claude-code-linux-x64/latest)
  version=$(jq -r .version <<<"$meta")
  current=$(sed -n 's/^  claudeVersion = "\(.*\)";/\1/p' "$file")

  if [[ "$version" == "$current" ]]; then
    echo "claude-code is up to date ($current)"
    return
  fi
  echo "claude-code: $current -> $version"

  local src_hash
  src_hash=$(jq -r .dist.integrity <<<"$meta")
  sed -i \
    -e "s|^  claudeVersion = \".*\";|  claudeVersion = \"${version}\";|" \
    -e "/claude-code-linux-x64-\${claudeVersion}.tgz\";/{n;s|hash = \".*\";|hash = \"${src_hash}\";|}" \
    "$file"
}

update_maven_indexer() {
  local file=overlays/maven-indexer-cli.nix
  local rev current
  rev=$(curl -fsSL https://api.github.com/repos/tangcent/maven-indexer-cli/commits/HEAD | jq -r .sha)
  current=$(sed -n 's/^  version = "\(.*\)";/\1/p' "$file")

  if [[ "$rev" == "$current" ]]; then
    echo "maven-indexer-cli is up to date (${current:0:7})"
    return
  fi
  echo "maven-indexer-cli: ${current:0:7} -> ${rev:0:7}"

  local src_hash
  src_hash=$(nix flake prefetch --json "github:tangcent/maven-indexer-cli/${rev}" | jq -r .hash)
  sed -i \
    -e "s|^  version = \".*\";|  version = \"${rev}\";|" \
    -e "/^  src = fetchFromGitHub/,/};/s|hash = \".*\";|hash = \"${src_hash}\";|" \
    "$file"

  set_npm_deps_hash "$file"
}

nix flake update
update_rea
update_claude
update_maven_indexer
echo "done"
