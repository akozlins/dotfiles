;

; https://www.emacswiki.org/emacs/WhiteSpace
; https://www.gnu.org/software/emacs/manual/html_node/elisp/Face-Attributes.html

(require 'whitespace)
(setq whitespace-style '(
    face
    spaces tabs newline
    space-mark newline-mark tab-mark
))
(setq whitespace-display-mappings '(
    (space-mark         ?\x20           [?\xB7]         [?.]            )
    (newline-mark       ?\n             [?\xB6 ?\n]     [?$ ?\n]        )
    (tab-mark           ?\t             [?\xBB ?\t]     [?\\ ?\t]       )
))

(set-face-attribute 'whitespace-space nil :background nil :foreground "#CCCCCC")
(set-face-attribute 'whitespace-tab nil :background nil :foreground "#CCCCCC")
(set-face-attribute 'whitespace-newline nil :background nil :foreground "#CCCCCC")

(global-whitespace-mode)
