local keymap = vim.api.nvim_set_keymap
local autocmd = vim.api.nvim_create_autocmd
local my_augroup = require('conf.builtin_extend').my_augroup
local bufmap = vim.api.nvim_buf_set_keymap

return {
    -- an installer for a bunch of CLI tools (e.g. LSP, linters)
    {
        'mason-org/mason.nvim',
        cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', 'MasonUninstall' },
        config = function()
            require('mason').setup()
        end,
    },
    {
        'milanglacier/yarepl.nvim',
        event = 'VeryLazy',
        lazy = vim.fn.argc(-1) == 0,
        config = function()
            local yarepl = require 'yarepl'
            local aider = require 'yarepl.extensions.aider'

            yarepl.setup {
                metas = {
                    aider = aider.create_aider_meta(),
                    python = false,
                    R = false,
                    shell = {
                        cmd = vim.o.shell,
                        wincmd = function(bufnr, name)
                            vim.api.nvim_open_win(bufnr, true, {
                                relative = 'cursor',
                                row = -4,
                                col = -6,
                                width = math.floor(vim.o.columns * 0.65),
                                height = math.floor(vim.o.lines * 0.4),
                                style = 'minimal',
                                title = name,
                                border = 'rounded',
                                title_pos = 'center',
                            })
                        end,
                    },
                },
            }

            require('yarepl.extensions.code_cell').register_text_objects {
                {
                    key = 'c',
                    start_pattern = '```.+',
                    end_pattern = '^```$',
                    ft = { 'rmd', 'quarto', 'markdown' },
                    desc = 'markdown code cells',
                },
                {
                    key = '<Leader>c',
                    start_pattern = '^# ?%%%%.*',
                    end_pattern = '^# ?%%%%.*',
                    ft = { 'r', 'python' },
                    desc = 'r/python code cells',
                },
                {
                    key = 'm',
                    start_pattern = '# COMMAND ---',
                    end_pattern = '# COMMAND ---',
                    ft = { 'r', 'python' },
                    desc = 'databricks code cells',
                },
                {
                    key = 'm',
                    start_pattern = '-- COMMAND ---',
                    end_pattern = '-- COMMAND ---',
                    ft = { 'sql' },
                    desc = 'databricks code cells',
                },
            }
        end,
        init = function()
            ----- Set Aichat Keymap ------
            keymap('n', '<Leader>cs', '<Plug>(REPLStart-aichat)', {
                desc = 'Start an Aichat REPL',
            })
            keymap('n', '<Leader>cf', '<Plug>(REPLFocus-aichat)', {
                desc = 'Focus on Aichat REPL',
            })
            keymap('n', '<Leader>ch', '<Plug>(REPLHide-aichat)', {
                desc = 'Hide Aichat REPL',
            })
            keymap('v', '<Leader>cr', '<Plug>(REPLSourceVisual-aichat)', {
                desc = 'Source visual region to Aichat',
            })
            keymap('v', '<Leader>cR', '<Plug>(REPLSendVisual-aichat)', {
                desc = 'Send visual region to Aichat',
            })
            keymap('n', '<Leader>crr', '<Plug>(REPLSendLine-aichat)', {
                desc = 'Send lines to Aichat',
            })
            keymap('n', '<Leader>cr', '<Plug>(REPLSourceOperator-aichat)', {
                desc = 'Source Operator to Aichat',
            })
            keymap('n', '<Leader>cR', '<Plug>(REPLSendOperator-aichat)', {
                desc = 'Send Operator to Aichat',
            })
            keymap('n', '<Leader>ce', '<Plug>(REPLExec-aichat)', {
                desc = 'Execute command in aichat',
            })
            keymap('n', '<Leader>cq', '<Plug>(REPLClose-aichat)', {
                desc = 'Quit Aichat',
            })
            keymap('n', '<Leader>cc', '<CMD>REPLCleanup<CR>', {
                desc = 'Clear aichat REPLs.',
            })

            ----- Set Aider Keymap ------
            -- general keymap from yarepl
            keymap('n', '<Leader>as', '<Plug>(REPLStart-aider)', {
                desc = 'Start an aider REPL',
            })
            keymap('n', '<Leader>af', '<Plug>(REPLFocus-aider)', {
                desc = 'Focus on aider REPL',
            })
            keymap('n', '<Leader>ah', '<Plug>(REPLHide-aider)', {
                desc = 'Hide aider REPL',
            })
            keymap('v', '<Leader>ar', '<Plug>(REPLSendVisual-aider)', {
                desc = 'Send visual region to aider',
            })
            keymap('n', '<Leader>arr', '<Plug>(REPLSendLine-aider)', {
                desc = 'Send lines to aider',
            })
            keymap('n', '<Leader>ar', '<Plug>(REPLSendOperator-aider)', {
                desc = 'Send Operator to aider',
            })

            -- special keymap from aider
            keymap('n', '<Leader>ae', '<Plug>(AiderExec)', {
                desc = 'Execute command in aider',
            })
            keymap('n', '<Leader>ay', '<Plug>(AiderSendYes)', {
                desc = 'Send y to aider',
            })
            keymap('n', '<Leader>an', '<Plug>(AiderSendNo)', {
                desc = 'Send n to aider',
            })
            keymap('n', '<Leader>aa', '<Plug>(AiderSendAbort)', {
                desc = 'Send abort to aider',
            })
            keymap('n', '<Leader>aq', '<Plug>(AiderSendExit)', {
                desc = 'Send exit to aider',
            })
            keymap('n', '<Leader>ama', '<Plug>(AiderSendAskMode)', {
                desc = 'Switch aider to ask mode',
            })
            keymap('n', '<Leader>amc', '<Plug>(AiderSendCodeMode)', {
                desc = 'Switch aider to code mode',
            })
            keymap('n', '<Leader>amC', '<Plug>(AiderSendContextMode)', {
                desc = 'Switch aider to context mode',
            })
            keymap('n', '<Leader>amA', '<Plug>(AiderSendArchMode)', {
                desc = 'Switch aider to architect mode',
            })
            keymap('n', '<Leader>ag', '<cmd>AiderSetPrefix<cr>', {
                desc = 'set aider prefix',
            })
            keymap('n', '<Leader>aG', '<cmd>AiderRemovePrefix<cr>', {
                desc = 'remove aider prefix',
            })
            keymap('n', '<Leader>a<space>', '<cmd>checktime<cr>', {
                desc = 'sync file changes by aider to nvim buffer',
            })

            ----- Set Shell Keymap ------
            keymap('n', '<Leader>ot', '<Plug>(REPLStart-shell)', {
                desc = 'Start or focus a shell',
            })
            keymap('n', '<Leader>t1', '<Plug>(REPLFocus-shell)', {
                desc = 'Focus on shell',
            })
            keymap('n', '<Leader>t0', '<Plug>(REPLHide-shell)', {
                desc = 'Hide shell REPL',
            })

            ----- Set Filetype Specific keymap -----
            local ft_to_repl = {
                r = 'radian',
                R = 'radian',
                rmd = 'radian',
                quarto = 'radian',
                markdown = 'radian',
                python = 'ipython',
                sh = 'bash',
            }

            autocmd('FileType', {
                pattern = { 'quarto', 'markdown', 'rmd', 'python', 'sh', 'REPL', 'r' },
                group = my_augroup,
                desc = 'set up REPL keymap',
                callback = function()
                    local repl = ft_to_repl[vim.bo.filetype]
                    repl = repl and ('-' .. repl) or ''

                    bufmap(0, 'n', '<LocalLeader>rs', string.format('<Plug>(REPLStart%s)', repl), {
                        desc = 'Start an REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>rf', '<Plug>(REPLFocus)', {
                        desc = 'Focus on REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>rv', '<CMD>FF repl_show<CR>', {
                        desc = 'View REPLs in telescope',
                    })
                    bufmap(0, 'n', '<LocalLeader>rh', '<Plug>(REPLHide)', {
                        desc = 'Hide REPL',
                    })
                    bufmap(0, 'v', '<LocalLeader>s', '<Plug>(REPLSourceVisual)', {
                        desc = 'Source visual region to REPL',
                    })
                    bufmap(0, 'v', '<LocalLeader>S', '<Plug>(REPLSendVisual)', {
                        desc = 'Send visual region to REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>ss', '<Plug>(REPLSendLine)', {
                        desc = 'Send line to REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>s', '<Plug>(REPLSourceOperator)', {
                        desc = 'Source current line to REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>S', '<Plug>(REPLSendOperator)', {
                        desc = 'Send current line to REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>re', '<Plug>(REPLExec)', {
                        desc = 'Execute command in REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>rq', '<Plug>(REPLClose)', {
                        desc = 'Quit REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>rc', '<CMD>REPLCleanup<CR>', {
                        desc = 'Clear REPLs.',
                    })
                    bufmap(0, 'n', '<LocalLeader>rS', '<CMD>REPLSwap<CR>', {
                        desc = 'Swap REPLs.',
                    })
                    bufmap(0, 'n', '<LocalLeader>r?', '<Plug>(REPLStart)', {
                        desc = 'Start an REPL from available REPL metas',
                    })
                    bufmap(0, 'n', '<LocalLeader>ra', '<CMD>REPLAttachBufferToREPL<CR>', {
                        desc = 'Attach current buffer to a REPL',
                    })
                    bufmap(0, 'n', '<LocalLeader>rd', '<CMD>REPLDetachBufferToREPL<CR>', {
                        desc = 'Detach current buffer to any REPL',
                    })

                    local function send_a_code_chunk()
                        local leader = vim.g.mapleader
                        local localleader = vim.g.maplocalleader
                        -- NOTE: in an expr mapping, <Leader> and <LocalLeader>
                        -- cannot be translated. You must use their literal value
                        -- in the returned string.

                        if vim.bo.filetype == 'r' or vim.bo.filetype == 'python' then
                            return localleader .. 'si' .. leader .. 'c'
                        elseif
                            vim.bo.filetype == 'rmd'
                            or vim.bo.filetype == 'quarto'
                            or vim.bo.filetype == 'markdown'
                        then
                            return localleader .. 'sic'
                        end
                    end

                    bufmap(0, 'n', '<localleader>sc', '', {
                        desc = 'send a code chunk',
                        callback = send_a_code_chunk,
                        expr = true,
                    })
                end,
            })
        end,
    },
    {
        'ludovicchabant/vim-gutentags',
        init = function()
            vim.g.gutentags_add_ctrlp_root_markers = 0
            vim.g.gutentags_ctags_exclude = { '.*', '**/.*' }
            vim.g.gutentags_generate_on_new = 0
            vim.g.gutentags_generate_on_missing = 0
            vim.g.gutentags_ctags_tagfile = '.tags'
            vim.g.gutentags_ctags_extra_args = { [[--fields=*]] }

            vim.filetype.add {
                pattern = {
                    ['%.tags'] = 'tags',
                },
            }
        end,
        event = 'VeryLazy',
    },
}
