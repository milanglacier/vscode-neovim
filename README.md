- [Getting Started](#getting-started)
- [Dependencies](#dependencies)
  - [general purpose deps](#general-purpose-deps)
- [Keymaps](#keymaps)
  - [VSCode Neovim keymaps](#vscode-neovim-keymaps)
    - [LSP Keymaps](#lsp-keymaps)
    - [Search/Find Keymaps](#searchfind-keymaps)
    - [UI Toggle Keymaps](#ui-toggle-keymaps)
    - [Window Management](#window-management)
    - [Tab Management](#tab-management)
    - [Navigation](#navigation)
    - [REPL Keymaps (R/Rmd)](#repl-keymaps-rrmd)
    - [REPL Keymaps (Python)](#repl-keymaps-python)
  - [Text Edit keymaps](#text-edit-keymaps)
    - [Align text keymaps](#align-text-keymaps)
    - [Comment keymaps](#comment-keymaps)
    - [Text objects for functions keymaps](#text-objects-for-functions-keymaps)
    - [Quick navigation keymaps](#quick-navigation-keymaps)
    - [Text objects enhancement keymaps](#text-objects-enhancement-keymaps)
    - [Block text movement](#block-text-movement)
    - [Surround pairs keymaps](#surround-pairs-keymaps)
    - [substitution keymaps](#substitution-keymaps)
    - [Other text objects keymaps](#other-text-objects-keymaps)
  - [Treesitter keymaps](#treesitter-keymaps)
    - [Syntax based text objects keymaps](#syntax-based-text-objects-keymaps)
    - [Syntaxa based navigations keymaps](#syntaxa-based-navigations-keymaps)
    - [Miscellenous](#miscellenous)
- [Other Notes](#other-notes)
- [Discussion](#discussion)

This configuration is derived from my [main Neovim
configuration](https://github.com/milanglacier/nvim).

The evolution of my VSCode-Neovim and main Neovim configurations spans several
years.

Initially, both configurations were maintained within the same codebase. I
began tweaking my Neovim configuration during the era when `vim-plug` was the
predominant plugin manager, even when `packer.nvim` was a new thing. Over time,
I grew weary of writing workaround code scattered throughout the configuration,
conditionally wrapped with `if vim.g.vscode`.

Although `lazy.nvim` now offers built-in conditional plugin activation based on
`vim.g.vscode`, I prefer not to rely heavily on such sugar. Given the
unpredictable nature of future developments, I decided to separate the
VSCode-Neovim configuration into its own branch, maintaining a cleaner main
Neovim configuration. This approach, which I followed for about two years,
involved periodic merges from the main branch approximately every few months.

Recently, upon analyzing both configurations, I noticed that my main Neovim
configuration had long since stopped adding new text-editing features—the
primary functionality shared between VSCode-Neovim and the main configuration.
Instead, I focused on enhancing the UI/UX of my main Neovim setup, developing
plugins like [minuet-ai.nvim](https://github.com/milanglacier/minuet-ai.nvim)
for LLM-based code completion and
[yarepl.nvim](https://github.com/milanglacier/yarepl.nvim) for REPL
management with tools like iPython, Radian, and aider-chat.

Given that VSCode-Neovim's scope remains strictly limited to text-editing
capabilities, maintaining both configurations in the same repository as
separate branches became unnecessary. This realization led to my decision to
create this new repository.

# Getting Started

**NOTE**: If you plan to use this configuration with `vscode-neovim` and wish
to use neovim both in the terminal and in vscode, I suggest creating two
folders in `~/.config` or your specified `$XDG_CONFIG` path. One is
`~/.config/nvim`, which uses the default configuration in the `main` repo, and
the other is `~/.config/vscode-neovim`, which uses the configuration in the
`vscode` branch. This takes advantage of the `NVIM_APPNAME` feature in `nvim 0.9`.

Then, Set `vscode-neovim.NVIM_APPNAME` to `vscode-neovim` in vscode settings.

Below are recommended `vscode-neovim` settings in your `settings.json` file.

```json
{
  "vscode-neovim.compositeKeys": {
    "jk": {
      "command": "vscode-neovim.escape"
    }
  },
  "extensions.experimental.affinity": {
    "asvetliakov.vscode-neovim": 1
  }, // run those plugins in a separate process for performance
  "vscode-neovim.NVIM_APPNAME": "vscode-neovim"
}
```

# Dependencies

## general purpose deps

2. A c compiler. Required to install treesitter parsers.

# Keymaps

NOTE: this only includes keymaps defined by myself,
and some of the default plugins keymaps
that I used frequently.

The `<Leader>` key is `<Space>`,
the `<LocalLeader>` key is `<Space><Space>` or `<Backslash>`.

## VSCode Neovim keymaps

These keymaps are specifically designed for VSCode integration:

### LSP Keymaps

| Mode | LHS          | RHS/Functionality         |
| ---- | ------------ | ------------------------- |
| n    | `<Leader>xr` | Find references           |
| n    | `<Leader>xd` | Show problems/diagnostics |
| n    | `gr`         | Go to references          |
| n    | `<Leader>ln` | Rename symbol             |
| n    | `<Leader>lf` | Format document           |
| n    | `<Leader>la` | Quick fix                 |
| n    | `<Leader>lr` | Refactor                  |
| n    | `<C-w>]`     | Reveal definition aside   |
| n    | `<Leader>w]` | Reveal definition aside   |
| v    | `<Leader>lf` | Format selection          |
| v    | `<Leader>la` | Quick fix                 |
| v    | `<Leader>lr` | Refactor                  |

### Search/Find Keymaps

| Mode | LHS          | RHS/Functionality       |
| ---- | ------------ | ----------------------- |
| n    | `<Leader>fR` | Find in files (ripgrep) |
| n    | `<Leader>fg` | Find in files (ripgrep) |
| n    | `<Leader>fc` | Show commands           |
| n    | `<Leader>ff` | Quick open              |
| v    | `<Leader>fc` | Show commands           |

### UI Toggle Keymaps

| Mode | LHS          | RHS/Functionality    |
| ---- | ------------ | -------------------- |
| n    | `<Leader>tp` | Toggle panel         |
| n    | `<Leader>ts` | Toggle sidebar       |
| n    | `<Leader>ta` | Toggle auxiliary bar |
| n    | `<Leader>tt` | Toggle terminal      |

### Window Management

In VSCode and Vim, window management operates differently. While Vim allows
multiple windows within a tab, VSCode allows multiple tabs within a window.

VSCode offers two distinct sets of commands for organizing your workspace:

"Move Active Group" commands rearrange the window layout, affecting all
associated tabs within that window.

"Move Editor" commands allow individual tabs to be transferred between
different windows.

| Mode | LHS          | RHS/Functionality          |
| ---- | ------------ | -------------------------- |
| n    | `<Leader>ww` | Focus next group           |
| n    | `<Leader>wp` | Focus previous group       |
| n    | `<Leader>wq` | Close active editor        |
| n    | `<Leader>wc` | Close active editor        |
| n    | `<Leader>wo` | Join all groups            |
| n    | `<Leader>w=` | Even editor widths         |
| n    | `<Leader>wh` | Focus left group           |
| n    | `<Leader>wj` | Focus below group          |
| n    | `<Leader>wk` | Focus above group          |
| n    | `<Leader>wl` | Focus right group          |
| n    | `<Leader>wH` | Move active group left     |
| n    | `<Leader>wJ` | Move active group down     |
| n    | `<Leader>wK` | Move active group up       |
| n    | `<Leader>wL` | Move active group right    |
| n    | `<Leader>wu` | Move editor to above group |
| n    | `<Leader>wd` | Move editor to below group |
| n    | `<Leader>wb` | Move editor to left group  |
| n    | `<Leader>wf` | Move editor to right group |
| n    | `<Leader>ws` | Split vertically           |
| n    | `<Leader>wv` | Split horizontally         |
| n    | `<Leader>w+` | Increase height            |
| n    | `<Leader>w-` | Decrease height            |
| n    | `<Leader>w>` | Increase width             |
| n    | `<Leader>w<` | Decrease width             |

### Tab Management

| Mode | LHS                | RHS/Functionality |
| ---- | ------------------ | ----------------- |
| n    | `<Leader><Tab>o`   | Close other tabs  |
| n    | `<Leader><Tab>n`   | New tab           |
| n    | `<Leader><Tab>c`   | Close tab         |
| n    | `<Leader><Tab>f`   | First tab         |
| n    | `<Leader><Tab>l`   | Last tab          |
| n    | `<Leader><Tab>[`   | Previous tab      |
| n    | `<Leader><Tab>]`   | Next tab          |
| n    | `<Leader><Tab>1-9` | Switch to tab 1-9 |

### Navigation

| Mode | LHS  | RHS/Functionality      |
| ---- | ---- | ---------------------- |
| n    | `]r` | Next reference         |
| n    | `[r` | Previous reference     |
| n    | `]d` | Next diagnostic        |
| n    | `[d` | Previous diagnostic    |
| n    | `]q` | Next search result     |
| n    | `[q` | Previous search result |

### REPL Keymaps (R/Rmd)

| Mode | LHS                | RHS/Functionality    |
| ---- | ------------------ | -------------------- |
| v    | `<LocalLeader>s`   | Run selection        |
| n    | `<LocalLeader>sc`  | Run current chunk    |
| n    | `<LocalLeader>sgg` | Run all chunks above |

### REPL Keymaps (Python)

| Mode | LHS                | RHS/Functionality           |
| ---- | ------------------ | --------------------------- |
| n    | `<LocalLeader>ss`  | Run selection interactively |
| v    | `<LocalLeader>s`   | Run selection interactively |
| n    | `<LocalLeader>sc`  | Run current cell            |
| n    | `<LocalLeader>sgg` | Run all cells above         |

## Text Edit keymaps

### Align text keymaps

The following keymaps rely on [vim-easy-align](https://github.com/junegunn/vim-easy-align)

| Mode | LHS | RHS/Functionality                                                 |
| ---- | --- | ----------------------------------------------------------------- |
| nv   | ga  | Align the motion / text object / selected text by input separator |

### Comment keymaps

The following keymaps rely on [mini.comment](https://github.com/echasnovski/mini.nvim)

| Mode | LHS | RHS/Functionality                                            |
| ---- | --- | ------------------------------------------------------------ |
| nv   | gc  | Comment / uncomment the motion / text object / selected text |
| n    | gcc | Comment /uncomment current line                              |
| o    | gc  | Text object: a commented text block                          |

### Text objects for functions keymaps

The following keymaps rely on [dsf.vim](https://github.com/AndrewRadev/dsf.vim)

| Mode | LHS  | RHS/Functionality                                     |
| ---- | ---- | ----------------------------------------------------- |
| n    | dsf  | Delete a function call, don't delete the arguments    |
| n    | dsnf | Delete next function call, don't delete the arguments |
| n    | csf  | Change a function call, keep arguments the same       |
| n    | csnf | Change next function call, keep arguments the same    |

### Quick navigation keymaps

The following keymaps rely on [vim-sneak](https://github.com/justinmk/vim-sneak)

| Mode | LHS | RHS/Functionality                       |
| ---- | --- | --------------------------------------- |
| nvo  | f   | Find the next input character           |
| nvo  | F   | Find the previous input character       |
| nvo  | t   | Guess from `t` vs `f` for vanilla vim   |
| nvo  | T   | Guess from `T` vs `F` for vanilla vim   |
| nv   | s   | Find the next 2 input chars             |
| o    | z   | Motion: Find the next 2 input chars     |
| n    | S   | Find the previous 2 input chars         |
| ov   | Z   | Motion: Find the previous 2 input chars |

### Text objects enhancement keymaps

The following keymaps rely on [mini.ai](https://github.com/echasnovski/mini.nvim)

| Mode | LHS  | RHS/Functionality                                             |
| ---- | ---- | ------------------------------------------------------------- |
| ov   | an   | Text object: find the next following "around" text object     |
| ov   | aN   | Text object: find the previous following "around" text object |
| ov   | in   | Text object: find the next following "inner" text object      |
| ov   | iN   | Text object: find the previous following "inner" text object  |
| nov  | `g(` | Motion: go to the start of the following "around" text object |
| nov  | `g)` | Motion: go to the end of the following "around" text object   |

### Block text movement

The following keymaps rely on [mini.move](https://github.com/echasnovski/mini.nvim)

| Mode | LHS     | RHS/Functionality            |
| ---- | ------- | ---------------------------- |
| v    | `<A-h>` | Move left the block of text  |
| v    | `<A-j>` | Move down the block of text  |
| v    | `<A-k>` | Move up the block of text    |
| v    | `<A-l>` | Move right the block of text |

### Surround pairs keymaps

The following keymaps rely on [mini.surround](https://github.com/echasnovski/mini.nvim)

| Mode | LHS | RHS/Functionality                                          |
| ---- | --- | ---------------------------------------------------------- |
| n    | yss | Add a surround pair for the whole line                     |
| n    | ys  | Add a surround pair for the following motion / text object |
| n    | yS  | Add a surround pair from cursor to line end                |
| v    | S   | Add a surround pair for selected text                      |
| n    | cs  | Change the surround pair                                   |
| n    | ds  | Delete the surround pair                                   |

### substitution keymaps

The following keymaps rely on [substitute.nvim](https://github.com/gbprod/substitute.nvim)

| Mode | LHS | RHS/Functionality                                                                                      |
| ---- | --- | ------------------------------------------------------------------------------------------------------ |
| nv   | gs  | Substitute the motion / text object / selected text by latest pasted text, don't cut the replaced text |
| n    | gss | Similar to `gs`, operate on the whole line                                                             |
| n    | gS  | Similar to `gs`, operate on text from cursor to line end                                               |

### Other text objects keymaps

The following keymaps rely on [vim-textobj-beween](https://github.com/thinca/vim-textobj-between)

| Mode | LHS | RHS/Functionality                                    |
| ---- | --- | ---------------------------------------------------- |
| ov   | ab  | Text object: around text between the input character |
| ov   | ib  | Text object: inner text between the input character  |

The following keymaps rely on [vim-textobj-chainmember](https://github.com/D4KU/vim-textobj-chainmember)

| Mode | LHS | RHS/Functionality                                     |
| ---- | --- | ----------------------------------------------------- |
| ov   | a.  | Text object: around a chain of chained method calls   |
| ov   | i.  | Text object: inner of a chain of chained method calls |

## Treesitter keymaps

### Syntax based text objects keymaps

| Mode | LHS  | RHS/Functionality                           |
| ---- | ---- | ------------------------------------------- |
| ov   | af   | Text object: around a function definition   |
| ov   | if   | Text object: inner of a function definition |
| ov   | ak   | Text object: the same as `aC`               |
| ov   | ik   | Text object: the same as `iC`               |
| ov   | al   | Text object: around a loop                  |
| ov   | il   | Text object: inner of a loop                |
| ov   | ac   | Text object: around if-else conditions      |
| ov   | ic   | Text object: inner of if-else conditions    |
| ov   | ae   | Text object: around a function call         |
| ov   | `aA` | Text object: around a parameter(argument)   |
| ov   | `iA` | Text object: inner of a parameter(argument) |

### Syntaxa based navigations keymaps

| Mode | LHS  | RHS/Functionality                           |
| ---- | ---- | ------------------------------------------- |
| n    | `]f` | Go to the start of next function definition |
| n    | `]k` | The same as `]<Leader>c`                    |
| n    | `]l` | Go to the start of next loop                |
| n    | `]c` | Go to the start of next if-else conditions  |

| Mode | LHS  | RHS/Functionality                         |
| ---- | ---- | ----------------------------------------- |
| n    | `]F` | Go to the end of next function definition |
| n    | `]K` | The same as `]<Leader>C`                  |
| n    | `]L` | Go to the end of next loop                |
| n    | `]C` | Go to the end of next if-else conditions  |

| Mode | LHS  | RHS/Functionality                               |
| ---- | ---- | ----------------------------------------------- |
| n    | `[f` | Go to the start of previous function definition |
| n    | `[k` | The same as `[<Leader>c`                        |
| n    | `[l` | Go to the start of previous loop                |
| n    | `[c` | Go to the start of previous if-else conditions  |

| Mode | LHS  | RHS/Functionality                             |
| ---- | ---- | --------------------------------------------- |
| n    | `[F` | Go to the end of previous function definition |
| n    | `[K` | The same as `[<Leader>C`                      |
| n    | `[L` | Go to the end of previous loop                |
| n    | `[C` | Go to the end of previous if-else conditions  |

### Miscellenous

| Mode | LHS     | RHS/Functionality                                 |
| ---- | ------- | ------------------------------------------------- |
| n    | `g<CR>` | Jump to the start of the selected treesitter node |
| n    | `g<BS>` | Jump to the end of the selected treesitter node   |
| vo   | `<CR>`  | Select region based on treesitter node            |

# Other Notes

1. `vim-sneak` defines relatively inconsistent behavior: in normal mode,
   use `s/S`, in operator pending mode, use `z/Z`, in visual mode,
   use `s/Z`. In normal mode, default mapping `s` is replaced.
   In op mode, use `z/Z` is to be compatible with `vim-surround` (mappings: `ys/ds/cs`),
   in visual mode, use `s/Z` is to be compatible with
   folding (mapping: `zf`) and `vim-surround` (mapping: `S`)

2. You need to define your leader key before defining any keymaps.
   Otherwise, keymap will not be correctly mapped with your leader key.

3. `vim-matchup` will (intentionally) hide the status-line if the matched pair are spanned
   over entire screen to show the other side of the pair.

# Discussion

1. It is recommended to use the mailing list `~northyear/nvim-devel@lists.sr.ht`.
2. Alternatively, you are also welcome to open a Github issue.
