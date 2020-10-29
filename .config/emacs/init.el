;

(setq debug-on-error t)

(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(setq emacs.config (concat (getenv "XDG_CONFIG_HOME") "/emacs"))
(setq emacs.cache (concat (getenv "XDG_CACHE_HOME") "/emacs"))

(load (concat emacs.config "/gui"))
(load (concat emacs.config "/edit"))
(load (concat emacs.config "/key"))

;; backup/autosave
(setq make-backup-files nil) ; no backup~
(setq auto-save-default nil) ; no #autosave#



(load (concat emacs.config "/install-packages"))
(install-packages
    'use-package
    'whitespace
    'org
    'undo-tree
)

(require 'use-package)
(use-package markdown-mode
    :ensure t
    :mode (
        ("\\.md$'" . markdown-mode)
    )
    :init (setq markdown-command "multimarkdown")
)
(use-package org
    :mode(
        ("\\.org$" . org-mode)
    )
)

(load (concat emacs.config "/whitespace"))



; https://www.emacswiki.org/emacs/IbufferMode
(global-set-key (kbd "C-x C-b") 'ibuffer)

; https://elpa.gnu.org/packages/undo-tree.html
; C-/ - undo
; C-? - redo
; C-x u - show undo tree
(require `undo-tree)
(global-undo-tree-mode)

;
