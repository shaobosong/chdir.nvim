local M = {}

local default_config = {
    sign = '-',
    start_index = 0,
}

M.config = {}

local function path_is_root(path)
    if vim.fn.has('win32') == 1 then
        return path:match("^[a-zA-Z]:[/\\]?$")
    else
        return path == "/"
    end
end

local function change_directory_by_index(index)
    local sign = M.config.sign
    local start_index = M.config.start_index
    local dirs = {}
    local dirs_index = start_index
    local path = vim.fn.expand("%:p:h") or vim.fn.getcwd()
    local base = ""
    local line = ""

    while not path_is_root(path) do
        base = vim.fn.fnamemodify(path, ":t")
        line = string.rep(sign, #base) .. dirs_index .. line
        table.insert(dirs, path)
        dirs_index = dirs_index + 1
        path = vim.fn.fnamemodify(path, ":h")
    end

    if vim.fn.has('win32') == 1 then
        line = sign .. dirs_index .. line
    end

    table.insert(dirs, path)

    if index == "" then
        vim.api.nvim_echo({{dirs[1], "None"}}, false, {})
        vim.api.nvim_echo({{line, "None"}}, false, {})

        vim.fn.inputsave()
        index = vim.fn.input("Type number and <Enter> (empty cancels): ")
        vim.fn.inputrestore()

        if index == "" then
            return
        end
    end

    index = (tonumber(index) or start_index) - start_index
    index = math.min(math.max(index, 0), #dirs - 1)

    vim.cmd("redraw | cd " .. dirs[index + 1])
    vim.api.nvim_echo({{dirs[index + 1], "None"}}, false, {})
    -- FIXME: vim.fn.expand("%:p:h") will change wired.
    -- vim.uv.chdir(dirs[index + 1])
end

function M.setup(user_config)
    M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
    vim.api.nvim_create_user_command("ChangeDirectory", function(opts)
        change_directory_by_index(opts.args)
    end, { nargs = '?' })
end

return M
