;

;; pgdown
(defun sfp-page-down ()
    (interactive)
    (setq this-command 'next-line)
    (next-line
        (- (window-text-height)
        next-screen-context-lines)
    )
)

;; pgup
(defun sfp-page-up ()
    (interactive)
    (setq this-command 'previous-line)
    (previous-line
        (- (window-text-height)
        next-screen-context-lines)
    )
)

(global-set-key [next] 'sfp-page-down)
(global-set-key [prior] 'sfp-page-up)

(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment   'utf-8)
(prefer-coding-system 'utf-8)

(setq tab-width 4)
