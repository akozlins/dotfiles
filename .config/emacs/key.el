;

(defun key.page-up ()
    (interactive)
    (setq this-command 'previous-line)
    (previous-line
        (- (window-text-height)
        next-screen-context-lines)
    )
)

(defun key.page-down ()
    (interactive)
    (setq this-command 'next-line)
    (next-line
        (- (window-text-height)
        next-screen-context-lines)
    )
)

(global-set-key [prior] 'key.page-up)
(global-set-key [next] 'key.page-down)
