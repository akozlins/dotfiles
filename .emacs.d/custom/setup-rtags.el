
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



(require 'projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)



(provide 'setup-rtags)
