return {
  settings = {
    pylsp = {
      plugins = {
        flake8 = { enabled = false },
        jedi_completion = { enabled = false },
        jedi_definition = { enabled = false },
        yapf = { enabled = false }, -- really slow
        rope_completion = { enabled = false },
        pylint = { enabled = false },
        pydocstyle = { enabled = false },
        preload = { enabled = false },
        mccabe = { enabled = false },
        jedi_symbols = { enabled = false },
        jedi_references = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false }
      }
    }
  }
}
