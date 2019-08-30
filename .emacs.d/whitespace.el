;

(require 'whitespace)
(setq whitespace-style '(
    space-mark
    newline-mark
    tab-mark
))
(setq whitespace-display-mappings '(
    (space-mark         ?\x20           [?\xB7]         [?.]            )
    (newline-mark       ?\n             [?\xB6 ?\n]     [?$ ?\n]        )
    (tab-mark           ?\t             [?\xBB ?\t]     [?\\ ?\t]       )
))
(global-whitespace-mode)
