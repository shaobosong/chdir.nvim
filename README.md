# chdir.nvim

## Description
A Neovim plugin to visualize and navigate through the parent directories of the current working directory. It displays the directory path with indexed markers, allowing quick navigation to any parent directory by entering the corresponding index.

Inspired by [cd-index.sh](https://gist.github.com/shaobosong/c6bd3f1b854b119641b5395b2f0e7752)

```txt
/home/randb/freedom/chdir.nvim/lua/chdir
----5-----4-------3----------2---1-----0
Type number and <Enter> (empty cancels):
```

## Installation
- lazy.nvim
```lua
{
    "shaobosong/chdir.nvim",
    lazy = true,
    cmd = { "ChangeDirectory" },
    keys = {
        { "<leader>ci", "<cmd>ChangeDirectory<cr>", mode = "" },
    },
    config = function ()
        require("chdir").setup({
            sign = '-',
        })
    end,
}
```
