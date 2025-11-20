vim.pack.add({ "https://github.com/ibhagwan/ts-vimdoc.nvim", },
  { confirm = false, })

vim.api.nvim_create_user_command("Vimdoc", function()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local input_file = "README.md"
  local output_file = "doc/" .. project_name .. ".txt"

  vim.ui.input({
    prompt = "Input file: ",
    default = input_file,
  }, function(input)
    if input then
      input_file = input
      vim.ui.input({
        prompt = "Output file: ",
        default = output_file,
      }, function(output)
        if output then
          output_file = output
          vim.ui.input({
            prompt = "Project name: ",
            default = project_name,
          }, function(name)
            if name then
              project_name = name

              require("ts-vimdoc").docgen({
                input_file = input_file,
                output_file = output_file,
                project_name = project_name,
              })
            end
          end)
        end
      end)
    end
  end)
end, {})
