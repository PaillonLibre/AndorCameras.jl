#! /bin/sh
#
# gendeps.sh --
#
# Bash script to generate Julia contants for Andor cameras.
#
#-------------------------------------------------------------------------------
#
# This file is part of "AndorCameras.jl" released under the MIT license.
#
# Copyright (C) 2017-2019, Éric Thiébaut.
#

if test $# != 2; then
   echo >&2 "Usage: $0 INP OUT"
   exit 1
fi
INP=$1
OUT=$2

if ! test -r "$INP"; then
   echo >&2 "$0: file '$INP' is not readable."
   exit 1
fi

# Generate header.
cat >"$OUT" <<'EOF'
#
# deps.jl --
#
# Definitions of types and constants for interfacing Andor cameras in Julia.
#
# *DO NOT EDIT* as this file is automatically generated for your machine.
#
#------------------------------------------------------------------------------
#
# This file is part of "AndorCameras.jl" released under the MIT license.
#
# Copyright (C) 2017-2019, Éric Thiébaut.
#

"""
```julia
using AndorCameras.Constants
```

makes all Andor cameras constants available (they are all prefixed with
`AT_`).

"""
module Constants

# Export prefixed constants.
export
EOF

# First pass to generate list of exported symbols.
sed -n <"$INP" >>"$OUT" \
    -e 's/[ \t][ \t]*/ /g' \
    -e '/^ *const AT_/{s/^ *const \(AT_[_A-Z0-9]*\).*/    \1,/;H}' \
    -e '${x;s/^[ \n]*/    /;s/,[ \n]*$//;p}'

# Second and third passes to generate code and definitions.
cat >>"$OUT" <<'EOF'

# Constants.
EOF
grep <"$INP" >>"$OUT" '^ *const  *AT_'
cat >>"$OUT" <<'EOF'

end # module Constants

using .Constants

# Dynamic library and other constants.
EOF
grep <"$INP" >>"$OUT" -v '^ *const  *AT_'
