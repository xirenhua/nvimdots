local M = {}

M.load = function()
    require("core.options").load()
    require("core.mappings").load()
    require("core.diagnostics").load()
    require("core.plugins").load()
end

return M
