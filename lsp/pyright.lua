return {
  settings = {
    disableOrganizeImports = true,
    flags = { debounce_text_changes = 300 },
    python = {
      analysis = {
        -- ignore = {"*"},
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        autoImportCompletion = true,
        useLibraryCodeForTypes = true,
        -- diagnosticSeverityOverrides = {
        --     reportGeneralTypeIssues = "none",
        --     reportOptionalMemberAccess = "none",
        --     reportOptionalSubscript = "none",
        --     reportPrivateImportUsage = "none"
        -- }
      },
      linting = { pylintEnabled = false },
    }
  }
}
