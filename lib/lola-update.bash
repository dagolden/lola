Lola:shim-maker() {
  shim=$(< "$LOLA_SRC/template/shim")
  shim="${shim/%%VERSION%%/$Lola_VERSION}"
  shim="${shim/%%LOLA_ROOT%%/$LOLA_ROOT}"
  local shim_install="$LOLA_ROOT/bin/lola-shim"
  mkdir -p "$LOLA_ROOT/bin"
  echo "$him" > "$shim_install"
  chmod +x "$shim_install"
}

Lola:shim-maker "$@"
