vim.api.nvim_create_user_command("Task", function(opts)
  vim.cmd("!task " .. opts.args)
end, {
  nargs = "*",
  complete = function()
    return vim.fn.systemlist("task --silent --list-all")
  end,
  desc = "Perform Taskfile.yml task",
})

vim.keymap.set("n", "", function() -- Maps <C-/> 'control slash'
  require("fzf-lua").fzf_exec("task --silent --list-all", {
    prompt = "Tasks❯ ",
    multiprocess = true, -- run command in a separate process
    preview = "task --list | grep '\\* {}:' | sed -e 's/\\* {}:\\s*//'",
    winopts = {
      height = 0.35,
      width = 0.30,
      preview = { wrap = "wrap", layout = "vertical" },
    },
    fzf_opts = {
      ["--multi"] = true,
    },
    actions = {
      ["default"] = function(selected, opts)
        vim.cmd({ cmd = "Task", args = selected })
      end,
    },
  })
end, { desc = "Taskfile options" })
