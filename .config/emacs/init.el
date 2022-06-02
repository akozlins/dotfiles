;

(setq gc-cons-threshold (* 32 1024 1024))

(setq debug-on-error t)

(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(setq emacs.config (concat (getenv "XDG_CONFIG_HOME") "/emacs"))
(setq emacs.cache (concat (getenv "XDG_CACHE_HOME") "/emacs"))

; https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html
(setq custom-file (concat emacs.config "/custom.el"))
(load (concat emacs.config "/custom.el"))

(load (concat emacs.config "/gui"))
(load (concat emacs.config "/edit"))
(load (concat emacs.config "/key"))

;; backup/autosave
(setq make-backup-files nil) ; no backup~
(setq auto-save-default nil) ; no #autosave#
;; recent files
(setq recentf-save-file (concat emacs.cache "/recentf"))



(load (concat emacs.config "/install-packages"))
(install-packages
    'use-package
    'whitespace
    'org
    'undo-tree
    'helm
    'counsel
    ; <https://github.com/jschaf/esup> - "Emacs Start Up Profiler" (usage: `M-x esup`)
    'esup
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

; helm
;(global-set-key (kbd "M-x") 'helm-M-x)
;(global-set-key (kbd "C-x C-f") 'helm-find-files)

; <https://oremacs.com/swiper/> - `ivy`
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)

(setq gc-cons-threshold (* 1 1024 1024))
