#!/bin/bash

TMPDIR=$(mktemp -d) || exit 1
RECTXT="$TMPDIR/vim.recovery.$USER.txt"
RECFN="$TMPDIR/vim.recovery.$USER.fn"
trap 'rm -f "$RECTXT" "$RECFN"; rmdir "$TMPDIR"' 0 1 2 3 15
for q in ~/.vim/swap/.*sw? ~/.vim/swap/*; do
  [[ -f $q ]] || continue
  rm -f "$RECTXT" "$RECFN"
  vim -X -r "$q" \
      -c "w! $RECTXT" \
      -c "let fn=expand('%')" \
      -c "new $RECFN" \
      -c "exec setline( 1, fn )" \
      -c w\! \
      -c "qa"
  if [[ ! -f $RECFN ]]; then
    echo "nothing to recover from $q"
    rm -f "$q"
    continue
  fi
  CRNT="$(cat $RECFN)"
  if diff --strip-trailing-cr --brief "$CRNT" "$RECTXT"; then
      echo "removing redundant $q"
      echo "  for $CRNT"
      rm -f "$q"
  else
      echo $q contains changes
      vim -n -d "$CRNT" "$RECTXT"
      rm -i "$q" || exit
  fi
done
