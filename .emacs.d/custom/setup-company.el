
(require 'rtags)
(setq rtags-path (expand-file-name "~/test/rtags/build/bin"))
(add-hook 'find-file-hook 'rtags-start-process-maybe)
(add-hook 'c-mode-common-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-common-hook 'rtags-start-process-unless-running)
(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(setq rtags-rc-log-enabled t)
(define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key c-mode-base-map (kbd "M-,") 'rtags-location-stack-back)
(define-key global-map (kbd "M-.") 'rtags-find-symbol-at-point)
(define-key global-map (kbd "M-,") 'rtags-location-stack-back)



(require 'auto-complete)
(ac-config-default)
(require 'rtags-ac)
(add-to-list  'ac-sources 'ac-source-rtags)
(define-key c-mode-map  [(tab)] 'ac-complete-rtags)
(define-key c++-mode-map  [(tab)] 'ac-complete-rtags)



(require 'company)
;(add-hook 'after-init-hook 'global-company-mode)
(global-company-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'c++-mode-hook 'company-mode)
;(define-key c-mode-map  [(tab)] 'company-complete)
;(define-key c++-mode-map  [(tab)] 'company-complete)



(require 'company-rtags)
(push 'company-rtags company-backends)



(require 'irony)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
;(defun my-irony-mode-hook ()
;  (define-key irony-mode-map [remap completion-at-point]
;    'irony-completion-at-point-async)
;  (define-key irony-mode-map [remap complete-symbol]
;    'irony-completion-at-point-async))
;(add-hook 'irony-mode-hook 'my-irony-mode-hook)
;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)



;(require 'company-irony)
;(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;(setq company-backends (delete 'company-semantic company-backends))
;(eval-after-load 'company
;  '(add-to-list
;    'company-backends 'company-irony))



;(require 'company-irony-c-headers)
;(eval-after-load 'company
;  '(add-to-list
;    'company-backends '(company-irony-c-headers company-irony)))



(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)



(provide 'setup-company)
