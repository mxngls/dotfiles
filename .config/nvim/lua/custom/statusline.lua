local M = {}

-- Get truncated path
local function get_truncated_filepath(filepath)
    if filepath == "" then return "" end

    local parts = vim.split(filepath, "/", { plain = true })

    if #parts <= 2 then return filepath end

    local rest = table.concat({ parts[#parts - 1], parts[#parts] }, '/')

    return '.../' .. rest
end

-- Get the current head when in a Git repository
local function get_git_head(filepath)
    local result = vim.system(
        { 'git',
            '--no-optional-locks',
            'status',
            '--porcelain=v2',
            '--branch',
        },
        { cwd = filepath, text = true }
    ):wait()

    if result.stdout:match("fatal: not a git repository") then return "" end

    local lines = vim.split(result.stdout, '\n')
    local info = ''
    local ahead = 0
    local behind = 0

    for _, line in ipairs(lines) do
        if line:match('^# branch.head') then
            info = line:match('^# branch.head (.+)')
        elseif line:match('^# branch.ab') then
            local ab = line:match('^# branch.ab (.[%d]+) (.[%d]+)')
            if ab then
                ahead = ab:match('.[(%d+)]')
                behind = ab:match('.* .[(%d+)]')
            end
        end
    end

    if ahead and tonumber(ahead) > 0 then
        info = info .. ' ' .. ahead
    end

    if behind and tonumber(behind) > 0 then
        info = info .. ' ' .. behind
    end

    return info
end

-- Custom statusline
function M.set_status()
    local winid = vim.g.statusline_winid
    local bufnr = vim.fn.winbufnr(winid)
    local bufname = vim.fn.bufname(bufnr)
    local filepath = vim.fn.fnamemodify(bufname, ':p')
    local dirpath = vim.fn.fnamemodify(bufname, ':p:h')

    local stl = {}

    -- Current buffer number
    table.insert(stl, string.format('[%d] ', bufnr))

    if vim.fn.filereadable(filepath) == 0 then
        table.insert(stl, bufname)
    else
        -- Truncated path
        table.insert(stl, get_truncated_filepath(filepath))

        -- Current Git branch
        table.insert(stl, ' ' .. get_git_head(dirpath) .. ' ')
    end

    -- File flags
    table.insert(stl, '%m%r%h%w ')

    -- Right aligned
    table.insert(stl, '%=')

    -- Current cursor position
    table.insert(stl, '%l:%02v ')
    table.insert(stl, '%P ')

    return table.concat(stl)
end

return M
