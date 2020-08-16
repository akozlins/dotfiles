;

(setq debug-on-error t)

(setq emacs.config (concat (getenv "DOTFILES") "/.emacs.d"))
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
