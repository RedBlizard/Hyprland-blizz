#!/bin/bash

hyprctl dispatch 'hl.dsp.exec_cmd(
    "helium-browser --app=http://localhost:9000",
    { workspace = "6" }
)'
