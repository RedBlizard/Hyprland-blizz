#!/usr/bin/env bash
# debug.sh - Safe wrapper to trigger Hyprland debug.lua dump
# Uses LUA_PATH to correctly resolve the custom modules.debug module
# Avoids conflict with Lua's built-in 'debug' library

set -euo pipefail

HYPR_DIR="${HOME}/.config/hypr"
CACHE_DIR="${HOME}/.cache/hypr"
DEBUG_MODULE="${HYPR_DIR}/modules/debug.lua"

# Ensure the cache directory exists for debug logging
mkdir -p "$CACHE_DIR"

# Verify the debug module exists before attempting to load
if [[ ! -f "$DEBUG_MODULE" ]]; then
    echo "✖ ERROR: debug.lua not found at: $DEBUG_MODULE" >&2
    exit 1
fi

# Set LUA_PATH so require('modules.debug') resolves correctly
# Execute the dump function safely via pcall
LUA_PATH="${HYPR_DIR}/?.lua;${HYPR_DIR}/?/init.lua;;" \
    lua -e "
        local ok, dbg = pcall(require, 'modules.debug')
        if not ok then
            io.stderr:write('✖ ERROR loading module: ' .. dbg .. '\n')
            os.exit(1)
        end
        dbg.dump()
    "
