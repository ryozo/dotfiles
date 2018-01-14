# percol configuration file

percol.import_keymap({
    "C-j" : lambda percol: percol.command.select_next(),
    "C-k" : lambda percol: percol.command.select_previous()
})
