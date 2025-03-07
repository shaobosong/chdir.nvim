local M = {}

local default_config = {
    sign = '-',
}

M.config = {}

function M.change_directory_by_index(index)
    local dirs = {}
    local dirs_index = 0
    local path = vim.fn.expand("%:p:h") or vim.fn.getcwd()
    local base = ""
    local line = ""

    while path ~= "/" do
        base = vim.fn.fnamemodify(path, ":t")
        line = string.rep(M.config.sign, #base) .. dirs_index .. line
        table.insert(dirs, path)
        dirs_index = dirs_index + 1
        path = vim.fn.fnamemodify(path, ":h")
    end
    table.insert(dirs, "/")

    if index == "" then
        vim.print(dirs[1])
        vim.print(line)

        vim.fn.inputsave()
        index = vim.fn.input("Type number and <Enter> (empty cancels): ")
        vim.fn.inputrestore()

        if index == "" then
            return
        end
    end

    index = tonumber(index) or 0
    index = math.min(math.max(index, 0), #dirs - 1)

    vim.cmd("cd " .. dirs[index + 1])
    -- FIXME: vim.fn.expand("%:p:h") will change wired.
    -- vim.uv.chdir(dirs[index + 1])
end

function M.setup(user_config)
    M.config = vim.tbl_deep_extend("force", default_config, user_config or {})
    vim.api.nvim_create_user_command("ChangeDirectory", function(opts)
        M.change_directory_by_index(opts.args)
    end, { nargs = '?' })
end

return M
