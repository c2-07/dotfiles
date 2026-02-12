# 🎨 Gruvbox Semantic Completion Colors

## Overview

The completion menu now uses **semantic coloring** where each completion kind gets a distinct Gruvbox color, making it easy to scan and identify what type of completion you're selecting at a glance.

## Color Assignments

### Callables (Blue - `#83a598`)
- **Function** 󰊕
- **Method** 󰊕
- **Constructor** 󰒓

→ Functions are blue because they're invocable/executable operations.

### Data & State (Aqua/Green)
- **Variable** 󰀫 - Aqua (`#8ec07c`)
- **Field** 󰆨 - Green (`#b8bb26`)
- **Property** 󰖷 - Green (`#b8bb26`)

→ Variables and fields represent mutable/assignable data.

### Type System (Purple - `#d3869b`)
- **Class** 󰠱
- **Struct** 󰙅
- **Interface** 󰠱
- **Enum** 󰎨
- **TypeParameter** 󰆩
- **EnumMember** 󰎪

→ Purple for types because they define structure and contracts.

### Language Constructs (Yellow - `#fabd2f`)
- **Keyword** 󰌋
- **Constant** 󰏿
- **Value** 󰎠

→ Yellow stands out for built-in language features and immutable values.

### Special/User-Defined (Orange - `#fe8019`)
- **Snippet** 󰩫
- **Event** 󰉁
- **Unit** 󰑭
- **Reference** 󰈇

→ Orange for special/custom content that deserves attention.

### Structural/Navigation
- **Module** 󰅩 - Red (`#fb4934`) - Important structural elements
- **File** 󰈙 - Aqua (`#8ec07c`) - File navigation
- **Folder** 󰉋 - Blue (`#83a598`) - Folder navigation
- **Operator** 󰆕 - Red (`#fb4934`) - Operations

### Less Important
- **Text** 󰉿 - Light Gray (`#a89984`)
- **Misc** 󰠳 - Gray (`#928374`)

## Menu Styling

### Selection Highlight
- **Background**: Dark Blue (`#076678`)
- **Foreground**: Bright Aqua (`#8ec07c`)
- **Bold**: Yes

Creates strong contrast for the currently selected item.

### Menu Background
- **Color**: `#282828` (slightly lighter than terminal bg for depth)

### Ghost Text (Inline Preview)
- **Color**: Gray (`#928374`) - subtle, not distracting
- **Style**: Italic

### Documentation Panel
- **Background**: `#282828` (matches menu)
- **Border**: Dark Gray (`#504945`)

## Matched Characters

When you type and characters match:
- **Color**: Bright Yellow (`#fabd2f`)
- **Style**: Bold

Makes it obvious which part of the completion matches your input.

## Why This Works

1. **Semantic Accuracy**: Each color represents the semantic meaning of the item type
2. **Fast Scanning**: Your eyes immediately understand what kind of item is highlighted
3. **Gruvbox Harmony**: All colors come from the Gruvbox palette, ensuring visual consistency
4. **High Contrast**: Bright accents on darker background = easy to read
5. **Reduced Cognitive Load**: You don't have to "read" each item; the color tells you instantly

## Testing the Colors

In Neovim, start typing in a Python/Rust/JS file to see:

```python
# Trigger completion with Ctrl+Space or auto-trigger
class MyClass:      # Purple (Class)
    field: int      # Green (Field)
    
    def method(self, var: str):  # Blue (Method), Aqua (Variable)
        const = 10  # Yellow (Constant)
        def_var = x # Aqua (Variable)
```

Run `:LspInfo` to verify your LSP servers are active and ready to provide completions.

## Customization

To modify colors, edit `/plugins/gruvbox.lua`:

1. Find the `CmpItemKind*` sections
2. Change the `fg` color value to your preferred hex code
3. Add `bold = true` for emphasis
4. Restart Neovim

Example:
```lua
vim.api.nvim_set_hl(0, "BlinkCmpItemKindFunction", {
    fg = "#83a598",  -- Change this to your color
    bold = true,     -- Add this for emphasis
})
```

## Color Reference (Gruvbox Hard Contrast)

| Color    | Hex     | Usage                          |
|----------|---------|--------------------------------|
| Red      | #fb4934 | Modules, Operators             |
| Green    | #b8bb26 | Fields, Properties             |
| Yellow   | #fabd2f | Keywords, Constants, Matches   |
| Blue     | #83a598 | Functions, Methods, Folders    |
| Purple   | #d3869b | Classes, Structs, Enums        |
| Orange   | #fe8019 | Snippets, Events, References   |
| Aqua     | #8ec07c | Variables, Files               |
| Gray     | #928374 | Text, Misc (muted)             |

## Appearance Icons

Each kind also gets a nerd-font icon that visually reinforces the category:
- 󰊕 Function/Method
- 󰀫 Variable
- 󰠱 Class/Interface
- 󰌋 Keyword
- 󰩫 Snippet
- 󰙅 Struct
- 󰎨 Enum
- etc.

Icons + Colors = Instant visual recognition of item type! 🎯
