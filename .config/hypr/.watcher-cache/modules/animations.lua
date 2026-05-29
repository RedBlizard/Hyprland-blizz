-- █▀▄▀█ Animations - Clean & Optimized
-- This configuration is structured for readability and maintainability

-- ============================================
-- BEZIER CURVES
-- ============================================

hl.curve("wind", {
  type = "bezier",
  points = { {0.05, 0.9}, {0.1, 1.05} }
})

hl.curve("winIn", {
  type = "bezier",
  points = { {0.1, 1.1}, {0.1, 1.1} }
})

hl.curve("winOut", {
  type = "bezier",
  points = { {0.3, -0.3}, {0, 1} }
})

hl.curve("liner", {
  type = "bezier",
  points = { {1, 1}, {1, 1} }
})

hl.curve("overshot", {
  type = "bezier",
  points = { {0.05, 0.9}, {0.1, 1.00} }
})

hl.curve("smoothOut", {
  type = "bezier",
  points = { {0.5, 0}, {0.99, 0.99} }
})

hl.curve("smoothIn", {
  type = "bezier",
  points = { {0.5, -0.5}, {0.68, 1.5} }
})

-- ============================================
-- ANIMATIONS
-- ============================================

hl.animation({
  leaf = "windows",
  enabled = true,
  speed = 6,
  bezier = "wind",
  style = "slide"
})

hl.animation({
  leaf = "windowsIn",
  enabled = false,
  speed = 5,
  bezier = "winIn",
  style = "slide"
})

hl.animation({
  leaf = "windowsOut",
  enabled = false,
  speed = 3,
  bezier = "smoothOut",
  style = "slide"
})

hl.animation({
  leaf = "windowsMove",
  enabled = false,
  speed = 5,
  bezier = "wind",
  style = "slide"
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 25.0,
    bezier = "linear",
})

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 75.0,
    bezier = "linear",
    style = "loop",
})

hl.animation({
  leaf = "fade",
  enabled = true,
  speed = 1,
  bezier = "smoothOut"
})

hl.animation({
  leaf = "workspaces",
  enabled = true,
  speed = 5,
  bezier = "overshot"
})

hl.animation({
  leaf = "specialWorkspace",
  enabled = true,
  speed = 6,
  bezier = "default",
  style = "slidefadevert -50%"
})

