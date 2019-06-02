;

(set-default-font "DejaVu Sans Mono 16")

(when window-system (set-frame-size (selected-frame) 120 35))

(tool-bar-mode -1)
(setq inhibit-startup-message t)

(setq display-time-day-and-date t display-time-24hr-format t)
(display-time)

(line-number-mode 1)
(column-number-mode 1)

(setq-default cursor-type 'bar)
(setq mouse-wheel-progressive-speed nil)

(fset 'yes-or-no-p 'y-or-n-p)