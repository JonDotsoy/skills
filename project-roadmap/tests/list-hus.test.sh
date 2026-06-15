#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LISTAR="$SCRIPT_DIR/../scripts/list-hus.sh"
TMP_DIR="$SCRIPT_DIR/.tmp"
TEST_ROADMAP="$TMP_DIR/ROADMAP.md"
FAILURES=0

mkdir -p "$TMP_DIR"
cleanup() { rm -f "$TEST_ROADMAP"; }
trap cleanup EXIT

run_test() {
  local fn="$1" desc="$2"
  cleanup
  if $fn; then
    echo "OK   $desc"
  else
    echo "FAIL $desc"
    ((FAILURES++))
  fi
}

assert_eq() {
  local actual="$1" expected="$2"
  if [[ "$actual" == "$expected" ]]; then return 0; fi
  diff <(echo "$expected") <(echo "$actual") | sed 's/^/     /'
  return 1
}

assert_empty() {
  local actual="$1"
  if [[ -z "$actual" ]]; then return 0; fi
  echo "     expected empty output, got: $actual"
  return 1
}

# ── Fixtures ───────────────────────────────────────────────────────────────────

write_roadmap_con_hus() {
  cat > "$TEST_ROADMAP" <<'EOF'
# ROADMAP

```mermaid
flowchart TB
  HU-1[HU-1: Primera historia]
  HU-2[HU-2: Segunda historia]
  HU-3[HU-3: Tercera historia]

  HU-1 --> HU-2
  HU-2 --> HU-3
```

## HU-1: Primera historia

Descripción de la primera.

## HU-2: Segunda historia

Descripción de la segunda.

## HU-3: Tercera historia

Descripción de la tercera.
EOF
}

write_roadmap_sin_hus() {
  cat > "$TEST_ROADMAP" <<'EOF'
# ROADMAP

```mermaid
flowchart TB
```
EOF
}

# ── Tests ──────────────────────────────────────────────────────────────────────

test_lista_hus_con_formato_correcto() {
  write_roadmap_con_hus
  local output; output=$(bash "$LISTAR" "$TEST_ROADMAP")
  assert_eq "$output" "- HU-1: Primera historia
- HU-2: Segunda historia
- HU-3: Tercera historia" || return 1
}

test_orden_preservado() {
  write_roadmap_con_hus
  local first; first=$(bash "$LISTAR" "$TEST_ROADMAP" | head -1)
  assert_eq "$first" "- HU-1: Primera historia" || return 1
}

test_roadmap_sin_hus_produce_salida_vacia() {
  write_roadmap_sin_hus
  local output; output=$(bash "$LISTAR" "$TEST_ROADMAP")
  assert_empty "$output" || return 1
}

test_falla_si_archivo_no_existe() {
  bash "$LISTAR" "$TMP_DIR/does-not-exist.md" 2>/dev/null
  [[ $? -ne 0 ]] || { echo "     expected exit != 0"; return 1; }
}

test_falla_sin_argumentos() {
  bash "$LISTAR" 2>/dev/null
  [[ $? -ne 0 ]] || { echo "     expected exit != 0"; return 1; }
}

# ── Runner ─────────────────────────────────────────────────────────────────────

run_test test_lista_hus_con_formato_correcto       "lists HUs with format '- HU-N: description'"
run_test test_orden_preservado                     "preserves order of appearance in the document"
run_test test_roadmap_sin_hus_produce_salida_vacia "ROADMAP with no HUs produces empty output"
run_test test_falla_si_archivo_no_existe           "fails if file does not exist"
run_test test_falla_sin_argumentos                 "fails if no argument is passed"

[[ $FAILURES -eq 0 ]] || exit 1
