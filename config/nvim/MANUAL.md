# Neovim Configuration Manual

> Your personalized Kickstart.nvim setup with Tokyo Night theme

## Table of Contents

1. [Core Concepts](#core-concepts)
2. [Navigation](#navigation)
3. [File Management](#file-management)
4. [Search & Find](#search--find)
5. [Code Intelligence (LSP)](#code-intelligence-lsp)
6. [Autocompletion](#autocompletion)
7. [Debugging](#debugging)
8. [Testing](#testing)
9. [Python Development](#python-development)
10. [Git Integration](#git-integration)
11. [Terminal](#terminal)
12. [Sessions](#sessions)
13. [Plugin Management](#plugin-management)
14. [Quick Reference Card](#quick-reference-card)

---

## Core Concepts

### Leader Key

Your **leader key** is `<Space>`. Most custom keybindings start with the leader key.

When you press `<Space>`, wait briefly and **which-key** will show you all available options.

### Modes

| Mode | How to Enter | Purpose |
|------|--------------|---------|
| Normal | `<Esc>` | Navigation, commands |
| Insert | `i`, `a`, `o` | Typing text |
| Visual | `v`, `V`, `<C-v>` | Selecting text |
| Command | `:` | Running commands |
| Terminal | `:term` or `<C-\>` | Shell commands |

### Settings Enabled

- **Relative line numbers**: Makes jumping easier (e.g., `5j` to go down 5 lines)
- **System clipboard sync**: Yank (`y`) copies to system clipboard
- **Smart case search**: Lowercase = case-insensitive, uppercase = case-sensitive
- **Persistent undo**: Undo history survives closing files
- **Format on save**: Python and Lua files auto-format when saved

---

## Navigation

### Basic Movement

| Key | Action |
|-----|--------|
| `h` `j` `k` `l` | Left, Down, Up, Right |
| `w` / `b` | Next/previous word |
| `e` | End of word |
| `0` / `$` | Start/end of line |
| `gg` / `G` | Start/end of file |
| `{` / `}` | Previous/next paragraph |
| `%` | Jump to matching bracket |

### Jumping with Line Numbers

With relative line numbers enabled:
```
  5  function foo()
  4    local x = 1
  3    local y = 2
  2    return x + y
  1  end
> 0  -- cursor here
  1
  2  function bar()
```

Type `5k` to jump up to `function foo()`, or `2j` to jump to `function bar()`.

### Scrolling (Centered)

| Key | Action |
|-----|--------|
| `<C-d>` | Half page down (cursor stays centered) |
| `<C-u>` | Half page up (cursor stays centered) |
| `<C-f>` | Full page down |
| `<C-b>` | Full page up |
| `zz` | Center current line on screen |

### Window/Split Navigation

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to window below |
| `<C-k>` | Move to window above |
| `<C-l>` | Move to right window |
| `<C-w>s` | Split horizontally |
| `<C-w>v` | Split vertically |
| `<C-w>q` | Close current window |
| `<C-w>=` | Equalize window sizes |

### Harpoon (Quick File Switching)

Bookmark your most-used files and jump to them instantly.

| Key | Action |
|-----|--------|
| `<leader>a` | Add current file to Harpoon |
| `<C-e>` | Open Harpoon menu |
| `<C-1>` | Jump to Harpoon file 1 |
| `<C-2>` | Jump to Harpoon file 2 |
| `<C-3>` | Jump to Harpoon file 3 |
| `<C-4>` | Jump to Harpoon file 4 |

**Workflow**: Open your main files, press `<leader>a` on each to bookmark them. Then use `<C-1>` through `<C-4>` to instantly switch between them.

---

## File Management

### Oil.nvim (File Explorer)

Oil treats directories as buffers—you can edit filenames like text!

| Key | Action |
|-----|--------|
| `-` | Open parent directory |
| `<CR>` | Open file/directory under cursor |
| `-` (in Oil) | Go up one directory |

**In Oil buffer:**

| Action | How |
|--------|-----|
| Create file | Type the filename on a new line, then `:w` |
| Delete file | `dd` on the line, then `:w` |
| Rename file | `cw` to change the name, then `:w` |
| Create directory | Type `dirname/` (with trailing slash), then `:w` |

### Buffers

Buffers are open files in memory.

| Key | Action |
|-----|--------|
| `<leader><leader>` | List all open buffers (Telescope) |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `:bd` | Close current buffer |
| `:e filename` | Open/create file |

---

## Search & Find

### In-File Search

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match (centered) |
| `N` | Previous match (centered) |
| `*` | Search for word under cursor |
| `<Esc>` | Clear search highlighting |
| `<leader>/` | Fuzzy search in current buffer |

### Telescope (Fuzzy Finder)

Telescope is your main tool for finding anything.

| Key | Action |
|-----|--------|
| `<leader>sf` | **[S]earch [F]iles** - Find files by name |
| `<leader>sg` | **[S]earch by [G]rep** - Find text in all files |
| `<leader>sw` | **[S]earch current [W]ord** - Grep word under cursor |
| `<leader>s.` | **Search Recent Files** - Previously opened files |
| `<leader><leader>` | **Find Buffers** - Switch between open files |
| `<leader>sh` | **[S]earch [H]elp** - Search help documentation |
| `<leader>sk` | **[S]earch [K]eymaps** - Find keybindings |
| `<leader>ss` | **[S]earch [S]elect** - List all Telescope pickers |
| `<leader>sd` | **[S]earch [D]iagnostics** - Find errors/warnings |
| `<leader>sr` | **[S]earch [R]esume** - Reopen last search |
| `<leader>s/` | **Search in Open Files** - Grep only in buffers |
| `<leader>sn` | **[S]earch [N]eovim files** - Search your config |

**Inside Telescope:**

| Key | Action |
|-----|--------|
| `<C-n>` / `<C-p>` | Next/previous result |
| `<CR>` | Open selected |
| `<C-x>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-/>` (insert) | Show all Telescope keymaps |
| `?` (normal) | Show all Telescope keymaps |
| `<Esc>` | Close Telescope |

---

## Code Intelligence (LSP)

LSP (Language Server Protocol) provides smart code features.

### Installed Language Servers

| Language | Server |
|----------|--------|
| Python | basedpyright |
| Lua | lua_ls |

### Go To Commands

| Key | Action |
|-----|--------|
| `grd` | **Go to Definition** - Where symbol is defined |
| `grr` | **Go to References** - All usages of symbol |
| `gri` | **Go to Implementation** - Implementation of interface |
| `grt` | **Go to Type Definition** - Type of symbol |
| `grD` | **Go to Declaration** - Declaration (e.g., C header) |
| `gO` | **Document Symbols** - List all symbols in file |
| `gW` | **Workspace Symbols** - List symbols in project |
| `<C-t>` | **Jump Back** - Return after a goto |

### Code Actions

| Key | Action |
|-----|--------|
| `grn` | **Rename** - Rename symbol across project |
| `gra` | **Code Action** - Quick fixes, refactors |
| `<leader>th` | **Toggle Inlay Hints** - Show/hide type hints |
| `K` | **Hover Documentation** - Show docs for symbol |

### Diagnostics

| Key | Action |
|-----|--------|
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |
| `<leader>q` | Open diagnostic quickfix list |
| `<leader>sd` | Search all diagnostics (Telescope) |

### Formatting

| Key | Action |
|-----|--------|
| `<leader>f` | Format current buffer |
| *(automatic)* | Files format on save |

**Formatters configured:**
- Python: `ruff_format`, `ruff_organize_imports`
- Lua: `stylua`

---

## Autocompletion

Powered by **blink.cmp** with super-tab preset.

### Basic Usage

Completions appear automatically as you type.

| Key | Action |
|-----|--------|
| `<Tab>` | Accept completion |
| `<S-Tab>` | Previous completion |
| `<C-n>` / `<Down>` | Next item |
| `<C-p>` / `<Up>` | Previous item |
| `<C-Space>` | Manually trigger completion / show docs |
| `<C-e>` | Dismiss completion menu |
| `<C-k>` | Toggle signature help |

### Completion Sources

Completions come from:
1. **LSP** - Language server suggestions
2. **Path** - File paths
3. **Snippets** - Code snippets (LuaSnip)
4. **Lazydev** - Neovim Lua API (when editing config)

### Snippets

After accepting a snippet:

| Key | Action |
|-----|--------|
| `<Tab>` | Jump to next placeholder |
| `<S-Tab>` | Jump to previous placeholder |

---

## Debugging

Powered by **nvim-dap** with **nvim-dap-python**.

### Starting a Debug Session

1. Open your Python file
2. Set breakpoints with `<leader>b`
3. Press `<F5>` to start debugging

### Debug Controls

| Key | Action |
|-----|--------|
| `<F5>` | Start / Continue |
| `<F1>` | Step Into |
| `<F2>` | Step Over |
| `<F3>` | Step Out |
| `<F7>` | Toggle Debug UI |
| `<leader>b` | Toggle Breakpoint |
| `<leader>B` | Set Conditional Breakpoint |

### Debug UI

Press `<F7>` to toggle the debug UI showing:
- Variables
- Call stack
- Breakpoints
- REPL console

---

## Testing

Powered by **neotest** with **neotest-python** (pytest).

### Running Tests

| Key | Action |
|-----|--------|
| `<leader>tr` | **[T]est [R]un** - Run test under cursor |
| `<leader>tf` | **[T]est [F]ile** - Run all tests in file |
| `<leader>ts` | **[T]est [S]ummary** - Toggle test summary panel |
| `<leader>to` | **[T]est [O]utput** - Show test output |
| `<leader>td` | **[T]est [D]ebug** - Debug test under cursor |

### Test Summary Panel

After running tests, press `<leader>ts` to see:
- Pass/fail status for each test
- Click to jump to test
- Re-run individual tests

### Debugging Tests

1. Place cursor on a test function
2. Press `<leader>td` to debug
3. Use normal debug controls (`<F1>`, `<F2>`, etc.)

---

## Python Development

### Virtual Environment Selection

| Key | Action |
|-----|--------|
| `<leader>vs` | **[V]env [S]elect** - Pick virtual environment |
| `<leader>vc` | **[V]env [C]ached** - Use last selected venv |

**Workflow:**
1. Open a Python file
2. Press `<leader>vs`
3. Select your `.venv` or virtual environment
4. LSP will restart with correct environment

The selector automatically finds:
- `.venv/` in project
- `venv/` directories
- Conda environments
- pyenv versions

### Python Workflow Summary

1. **Create venv**: `uv sync` (creates `.venv`)
2. **Select venv**: `<leader>vs` in Neovim
3. **Write code**: LSP provides completions, diagnostics
4. **Format**: Automatic on save (ruff)
5. **Test**: `<leader>tr` to run test under cursor
6. **Debug**: `<leader>b` to set breakpoint, `<F5>` to run

---

## Git Integration

Powered by **gitsigns.nvim**.

### Gutter Signs

| Sign | Meaning |
|------|---------|
| `+` | Added line |
| `~` | Modified line |
| `_` | Deleted line (below) |
| `‾` | Deleted line (above) |

### Git Hunk Commands

Hunks are chunks of changed code.

| Key | Action |
|-----|--------|
| `]c` | Next hunk |
| `[c` | Previous hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |

---

## Terminal

### Toggleterm (Floating Terminal)

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle floating terminal |
| `<Esc><Esc>` | Exit terminal mode (return to Normal) |

**Inside terminal:**
- Use normally like any terminal
- `<Esc><Esc>` to get back to Normal mode
- `<C-\>` to hide (keeps process running)

### Built-in Terminal

| Command | Action |
|---------|--------|
| `:term` | Open terminal in split |
| `:term python` | Open Python REPL |

---

## Sessions

Powered by **persistence.nvim**.

Sessions remember your open files, splits, and cursor positions.

| Key | Action |
|-----|--------|
| `<leader>qs` | **Restore Session** - For current directory |
| `<leader>ql` | **Restore Last Session** - Most recent session |
| `<leader>qd` | **Don't Save Session** - Disable for this session |

**Automatic behavior:**
- Sessions auto-save when you quit Neovim
- Opening Neovim in a project directory can restore the session

---

## Plugin Management

Powered by **lazy.nvim**.

### Commands

| Command | Action |
|---------|--------|
| `:Lazy` | Open plugin manager UI |
| `:Lazy sync` | Install missing + update all |
| `:Lazy update` | Update all plugins |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy health` | Check plugin health |
| `:Mason` | Manage LSP servers, formatters |

### In Lazy UI

| Key | Action |
|-----|--------|
| `I` | Install missing plugins |
| `U` | Update plugins |
| `S` | Sync (install + clean + update) |
| `X` | Clean unused |
| `?` | Help |
| `q` | Close |

---

## Quick Reference Card

```
╔═══════════════════════════════════════════════════════════════════╗
║                     NEOVIM QUICK REFERENCE                        ║
╠═══════════════════════════════════════════════════════════════════╣
║ LEADER KEY: <Space>     Press and wait for which-key menu         ║
╠═══════════════════════════════════════════════════════════════════╣
║ FILES & NAVIGATION                                                ║
║   <leader>sf     Find files          -            File explorer   ║
║   <leader>sg     Grep in project     <leader><leader>  Buffers    ║
║   <leader>s.     Recent files        <C-e>        Harpoon menu    ║
║   <leader>a      Add to Harpoon      <C-1/2/3/4>  Harpoon jump    ║
╠═══════════════════════════════════════════════════════════════════╣
║ CODE INTELLIGENCE                                                 ║
║   grd            Go to definition    grr          Find references ║
║   grn            Rename symbol       gra          Code action     ║
║   K              Hover docs          <leader>f    Format          ║
║   gO             Document symbols    <leader>th   Toggle hints    ║
╠═══════════════════════════════════════════════════════════════════╣
║ COMPLETION (blink.cmp)                                            ║
║   <Tab>          Accept              <C-n>/<C-p>  Navigate        ║
║   <C-Space>      Trigger/show docs   <C-e>        Dismiss         ║
╠═══════════════════════════════════════════════════════════════════╣
║ DEBUGGING                                                         ║
║   <F5>           Start/Continue      <F1>         Step into       ║
║   <F2>           Step over           <F3>         Step out        ║
║   <leader>b      Toggle breakpoint   <F7>         Toggle UI       ║
╠═══════════════════════════════════════════════════════════════════╣
║ TESTING                                                           ║
║   <leader>tr     Run nearest test    <leader>tf   Run file        ║
║   <leader>ts     Test summary        <leader>td   Debug test      ║
╠═══════════════════════════════════════════════════════════════════╣
║ PYTHON                                                            ║
║   <leader>vs     Select venv         <leader>vc   Use cached venv ║
╠═══════════════════════════════════════════════════════════════════╣
║ TERMINAL & SESSIONS                                               ║
║   <C-\>          Toggle terminal     <Esc><Esc>   Exit terminal   ║
║   <leader>qs     Restore session     <leader>ql   Last session    ║
╠═══════════════════════════════════════════════════════════════════╣
║ MOVEMENT ENHANCEMENTS                                             ║
║   <C-d>/<C-u>    Scroll (centered)   n/N          Search centered ║
║   J/K (visual)   Move lines up/down                               ║
╠═══════════════════════════════════════════════════════════════════╣
║ WINDOWS                                                           ║
║   <C-h/j/k/l>    Navigate splits     <C-w>v       Vertical split  ║
║   <C-w>s         Horizontal split    <C-w>q       Close window    ║
╠═══════════════════════════════════════════════════════════════════╣
║ GETTING HELP                                                      ║
║   <leader>sh     Search help         <leader>sk   Search keymaps  ║
║   :Lazy          Plugin manager      :Mason       LSP manager     ║
║   :checkhealth   Diagnose issues     :Tutor       Vim tutorial    ║
╚═══════════════════════════════════════════════════════════════════╝
```

---

## Tips for Efficient Navigation

### 1. Use Relative Numbers
Instead of `jjjjj`, type `5j`. Look at the relative number and jump directly.

### 2. Use Harpoon for Main Files
In most projects, you work with 3-5 files constantly. Harpoon them once, then `<C-1>` through `<C-4>` forever.

### 3. Use Telescope for Everything Else
- Don't know the filename? `<leader>sf` and fuzzy search
- Looking for a function? `<leader>sg` and grep
- Want to see recent files? `<leader>s.`

### 4. Let LSP Do the Work
- Don't search for definitions manually—use `grd`
- Don't manually rename—use `grn`
- Trust the red squiggles—they're usually right

### 5. Master the Search + Center Pattern
Search with `/`, then `n` and `N` keep you centered. You'll never lose context.

### 6. Use Visual Mode + J/K
Select lines with `V`, then `J`/`K` to rearrange code blocks. Much faster than cut/paste.

---

## Troubleshooting

### Plugins Not Working

```vim
:Lazy sync
:checkhealth
```

### LSP Not Attaching

```vim
:LspInfo          " Check LSP status
:Mason            " Ensure server is installed
:LspRestart       " Restart LSP
```

### Python Environment Issues

```vim
:lua print(vim.fn.exepath('python'))   " Check which Python
<leader>vs                              " Select correct venv
```

### Format Not Working

```vim
:ConformInfo      " Check formatter status
```

---

*Generated for your Kickstart.nvim configuration with Tokyo Night theme.*
