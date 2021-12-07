local M = {}

M.config = {
    ["*"] = {
        {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    },
    json = {{cmd = {"prettier -w"}}},
    yaml = {{cmd = {"prettier -w"}}},
    html = {{cmd = {"prettier -w"}}},
    markdown = {{cmd = {"prettier -w"}}},
    javascript = {{cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}},
    go = {{cmd = {"gofumpt -w", "goimports -w"}}},
    lua = {{cmd = {"lua-format -i"}}},
    sh = {{cmd = {"shfmt -w"}}},
    fish = {{cmd = {"fish_indent -w"}}},
    sql = {{cmd = {"pg_format -i"}}}
}

M.setup = function()
    local status_ok, format = pcall(require, "format")
    if not status_ok then return end
    format.setup(M.config)
end

return M
