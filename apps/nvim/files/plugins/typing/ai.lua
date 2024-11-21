return {
    {
        "David-Kunz/gen.nvim",
        enabled = true,
        lazy = false,
        opts = {
            model = "mistral", -- https://ollama.com/library
            host = "localhost", -- The host running the Ollama service.
            port = "11434", -- The port on which the Ollama service is listening.
            display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
            show_prompt = true -- Shows the prompt submitted to Ollama.
        }
    }
}

