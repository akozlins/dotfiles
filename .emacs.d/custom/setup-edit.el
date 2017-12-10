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

;; Tabs/Spaces
(setq mode-require-final-newline t) ; add a newline to end of file
(setq-default indent-tabs-mode nil) ; Use spaces instead of tabs
(setq tab-width 4) ; Set default tab width to 4

;; Enable clipboard
(setq x-select-enable-clipboard t)

(setq mouse-yank-at-point t)

;; show tabs/spaces
(require 'whitespace)
(global-whitespace-mode 1)
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; disable comment indentation
(require 'cc-mode)
(eval-after-load 'cc-mode '(progn
    (define-key c-mode-base-map "/" 'self-insert-command)
    (define-key c-mode-base-map "*" 'self-insert-command)
))

(require 'evil)
;(evil-mode 1)

(require 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)

(require 'highlight-symbol)
(global-set-key [(control f3)] 'highlight-symbol)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)

;; line diff
(require 'diff-hl)
(diff-hl-mode 1)

(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq speedbar-use-images nil)
(sr-speedbar-open)
(with-current-buffer sr-speedbar-buffer-name
    (setq window-size-fixed 'width)
)

;; compile
(global-set-key (kbd "<f5>") (lambda ()
                                 (interactive)
                                 (setq-local compilation-read-command nil)
                                 (call-interactively 'compile)
))

(set-default-font "DejaVu Sans Mono 16")

(require 'tabbar)
(tabbar-mode 1)
(defun my-tabbar-buffer-groups ()
    (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
                ((eq major-mode 'dired-mode) "emacs")
                (t "user"))))
(setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)

(provide 'setup-edit)
