#!/bin/bash
set -e

HERE=$(cd "$(dirname "$0")" && pwd)
# Remember to amend repository name when C-SCAPE-COMP is released as C-SCAPE.
JETSCAPE="${GITHUB_WORKSPACE:-/home/jetscape-user/jetscape}/${REPO_NAME:-C-SCAPE-COMP}"
ANALYSIS=$(dirname "$HERE")
CONFIG=""
OUTPUT=""
REFERENCE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -j|-a|-c|-o|-r)
      [[ $# -ge 2 ]] || { echo "Missing value for $1" >&2; exit 2; }
      case "$1" in
        -j) JETSCAPE="$2";; -a) ANALYSIS="$2";; -c) CONFIG="$2";;
        -o) OUTPUT="$2";; -r) REFERENCE="$2";;
      esac
      shift 2;;
    *) echo "Unknown argument: $1" >&2; exit 2;;
  esac
done

OUTPUT="${OUTPUT:-$ANALYSIS/test_cscape/output/new}"
REFERENCE="${REFERENCE:-$ANALYSIS/test_cscape/output/latest}"
[[ -f "$CONFIG" ]] || { echo "Missing XML config: $CONFIG" >&2; exit 2; }
[[ "$OUTPUT" != "$REFERENCE" && "$OUTPUT" != "$REFERENCE/"* ]] || { echo "New output folder must not be the reference folder" >&2; exit 2; }
CASE=$(basename "$CONFIG" .xml)

PREFIX="$CASE"
FILES=("$PREFIX.dat" "$PREFIX.hepmc" "${PREFIX}_final_state_partons.dat" "${PREFIX}_final_state_hadrons.dat")
mkdir -p "$OUTPUT/$CASE"
cd "$JETSCAPE/build"
for file in "${FILES[@]}"; do rm -f -- "$file" "$OUTPUT/$CASE/$file"; done

# Trento data generated in build directory should be removed before subsequent run.
rm -rf -- trento_data

printf 'Running %s\n' "$CASE"
if ! ./runJetscape "$CONFIG" "$JETSCAPE/config/jetscape_main.xml" > "$OUTPUT/$CASE/run.log" 2>&1; then
  echo "Run failed: $CASE (see $OUTPUT/$CASE/run.log)" >&2
  exit 1
fi

for file in "${FILES[@]}"; do
  [[ -s "$file" ]] || { echo "Missing output: $CASE/$file" >&2; exit 1; }
  mv -- "$file" "$OUTPUT/$CASE/$file"
done

for file in "${FILES[@]}"; do
  [[ -s "$REFERENCE/$CASE/$file" ]] || { echo "Missing reference: $CASE/$file" >&2; exit 1; }
  cmp -- "$REFERENCE/$CASE/$file" "$OUTPUT/$CASE/$file" || { echo "Regression failed: $CASE/$file" >&2; exit 1; }
done

echo "PASS: $CASE (4 files)"
