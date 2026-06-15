#!/usr/bin/env bash
#
# add-hu.test.sh — Integration tests for add-hu.sh
#
# What it does:
#   Runs add-hu.sh against temporary ROADMAPs and verifies that user
#   stories are added with the correct format.
#
# How it works:
#   - Each test receives a fresh temporary ROADMAP (empty or pre-populated).
#   - run_test() invokes the test function and reports OK / FAIL.
#   - assert_eq() compares actual output with expected; prints diff on mismatch.
#   - Exits with code 1 if at least one test failed.
#
# Usage:
#   bash tests/add-hu.test.sh
#
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADD="$SCRIPT_DIR/../scripts/add-hu.sh"
TMP_DIR="$SCRIPT_DIR/.tmp"
TEST_ROADMAP=""
ROADMAP_IDX=0
FAILURES=0

mkdir -p "$TMP_DIR"
echo '*' > "$TMP_DIR/.gitignore"

run_test() {
  local fn="$1" desc="$2"
  ((ROADMAP_IDX++))
  TEST_ROADMAP="$TMP_DIR/ROADMAP-test-${ROADMAP_IDX}.md"
  rm -f "$TEST_ROADMAP"
  if $fn; then
    echo "OK   $desc"
  else
    echo "FAIL $desc"
    ((FAILURES++))
  fi
}

assert_contains() {
  local content="$1" needle="$2"
  if grep -qF -- "$needle" <<< "$content"; then return 0; fi
  echo "     expected to contain: $needle"
  return 1
}

assert_not_contains() {
  local content="$1" needle="$2"
  if ! grep -qF -- "$needle" <<< "$content"; then return 0; fi
  echo "     expected NOT to contain: $needle"
  return 1
}

# ── Tests ──────────────────────────────────────────────────────────────────────

test_crear_desde_cero() {
  bash "$ADD" "$TEST_ROADMAP" \
    --description "First story" \
    --body "Description of the first story."

  [[ -f "$TEST_ROADMAP" ]] || { echo "     file was not created"; return 1; }
  local c; c=$(cat "$TEST_ROADMAP")
  assert_contains "$c" "HU-1[HU-1: First story]"         || return 1
  assert_contains "$c" "## HU-1: First story"             || return 1
  assert_contains "$c" "Description of the first story."  || return 1
}

test_agregar_sin_dependencias() {
  bash "$ADD" "$TEST_ROADMAP" \
    --description "First" --body "Body of the first."
  bash "$ADD" "$TEST_ROADMAP" \
    --description "Second" --body "Body of the second."

  local c; c=$(cat "$TEST_ROADMAP")
  assert_contains "$c" "HU-1[HU-1: First]"   || return 1
  assert_contains "$c" "HU-2[HU-2: Second]"  || return 1
  assert_contains "$c" "## HU-1: First"       || return 1
  assert_contains "$c" "## HU-2: Second"      || return 1
  assert_not_contains "$c" "-->"              || return 1
}

test_agregar_con_dependencias() {
  bash "$ADD" "$TEST_ROADMAP" \
    --description "First" --body "Body of the first."
  bash "$ADD" "$TEST_ROADMAP" \
    --description "Second" --body "Body of the second."
  bash "$ADD" "$TEST_ROADMAP" \
    --description "Third" --body "Body of the third." \
    --dep HU-1 --dep HU-2

  local c; c=$(cat "$TEST_ROADMAP")
  assert_contains "$c" "HU-1 --> HU-3"    || return 1
  assert_contains "$c" "HU-2 --> HU-3"    || return 1
  assert_contains "$c" "## HU-3: Third"   || return 1
}

test_falla_sin_description() {
  bash "$ADD" "$TEST_ROADMAP" --body "Body." 2>/dev/null
  [[ $? -ne 0 ]] || { echo "     expected exit != 0"; return 1; }
}

test_falla_sin_body() {
  bash "$ADD" "$TEST_ROADMAP" --description "No body" 2>/dev/null
  [[ $? -ne 0 ]] || { echo "     expected exit != 0"; return 1; }
}

test_falla_sin_roadmap_arg() {
  bash "$ADD" --description "Desc" --body "Body" 2>/dev/null
  [[ $? -ne 0 ]] || { echo "     expected exit != 0"; return 1; }
}

# ── Runner ─────────────────────────────────────────────────────────────────────

run_test test_crear_desde_cero         "creates ROADMAP from non-existent file"
run_test test_agregar_sin_dependencias "adds HU without dependencies"
run_test test_agregar_con_dependencias "adds HU with --dep dependencies"
run_test test_falla_sin_description    "fails when --description is missing"
run_test test_falla_sin_body           "fails when --body is missing"
run_test test_falla_sin_roadmap_arg    "fails when path argument is missing"

[[ $FAILURES -eq 0 ]] || exit 1
