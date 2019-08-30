;

(setq debug-on-error t)

(load "~/.emacs.d/gui")
(load "~/.emacs.d/edit")

;; backup/autosave
(setq make-backup-files nil) ; no backup~
(setq auto-save-default nil) ; no #autosave#



(load "~/.emacs.d/install-packages")
(install-packages
    'use-package
    'whitespace
)

(require 'use-package)
(use-package markdown-mode
    :ensure t
    :mode (
        ("\\.md\\'" . markdown-mode)
    )
    :init (setq markdown-command "multimarkdown")
)

(load "~/.emacs.d/whitespace")
