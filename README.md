# chdir.nvim

## Description
A Neovim plugin to visualize and navigate through the parent directories of the current working directory. It displays the directory path with indexed markers, allowing quick navigation to any parent directory by entering the corresponding index.

Inspired by [cd-index.sh](https://gist.github.com/shaobosong/c6bd3f1b854b119641b5395b2f0e7752)

## Installation
- lazy.nvim
```lua
{
    "shaobosong/chdir.nvim",
    config = function ()
        require("chdir").setup({
            sign = '-',
        })
    end,
}
```
