(setq debug-on-error t)



(when window-system (set-frame-size (selected-frame) 120 35))

(tool-bar-mode -1)
(setq inhibit-startup-message t)

(setq display-time-day-and-date t display-time-24hr-format t)
(display-time)

(line-number-mode 1)
(column-number-mode 1)

;; backup/autosave
(setq make-backup-files nil) ; no backup~
(setq auto-save-default nil) ; no #autosave#
;(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))

(setq-default cursor-type 'bar)
(setq mouse-wheel-progressive-speed nil)

(fset 'yes-or-no-p 'y-or-n-p)

(setq c-default-style "java")



(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(defconst my-packages '(
    helm
    helm-gtags
    helm-swoop
    evil
    ws-butler
    highlight-symbol
    diff-hl
    sr-speedbar
    tabbar
    projectile
    helm-projectile
    company
;    company-c-headers
;    helm-company
    irony
;    company-irony
;    company-irony-c-headers
    rtags
    auto-complete
;    flycheck
))

(defun install-packages ()
    "Install required packages."
    (interactive)
    (unless package-archive-contents
        (package-refresh-contents)
    )
    (dolist (package my-packages)
        (unless (package-installed-p package)
            (package-install package)
        )
    )
)
(install-packages)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-helm)
(setq helm-gtags-prefix-key "\C-cg") ; set before helm-gtags
(require 'setup-helm-gtags)
(require 'setup-edit)
(require 'setup-rtags)

(define-key c-mode-base-map (kbd "C-c C-c") 'kill-ring-save)
;(global-set-key (kbd "C-cc") 'kill-ring-save)
;(global-set-key (kbd "C-c C-c") 'yank)
;(global-set-key (kbd "C-c C-c") 'kill)

(global-set-key (kbd "C-x C-b") 'ibuffer)
