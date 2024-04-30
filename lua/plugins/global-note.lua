local get_project_name = function()
  local project_directory, err = vim.loop.cwd()
  if project_directory == nil then
    vim.notify(err, vim.log.levels.WARN)
    return nil
  end

  local project_name = vim.fs.basename(project_directory)
  if project_name == nil then
    vim.notify("Unable to get the project name", vim.log.levels.WARN)
    return nil
  end

  return project_name
end

return {
  "backdround/global-note.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local prefix = "<Leader>N"

        maps.n[prefix] = { desc = "Notes" }
        maps.n[prefix .. "g"] = {
          function() require("global-note").toggle_note() end,
          desc = "Open global note",
        }
        maps.n[prefix .. "p"] = {
          function() require("global-note").toggle_note "project_local" end,
          desc = "Open project note",
        }
      end,
    },
  },
  opts = {
    additional_presets = {
      project_local = {
        command_name = "ProjectNote",
        filename = function() return get_project_name() .. ".md" end,
        title = function() return "Note for project " .. get_project_name() end,
      },
    },
  },
}
