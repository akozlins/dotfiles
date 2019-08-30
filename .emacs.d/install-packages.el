;

(require 'package)
(add-to-list
    'package-archives
    '("melpa-stable" . "https://stable.melpa.org/packages/")
    t
)
(package-initialize)

(defun install-packages (&rest packages)
    "install packages"
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
    (unless package-archive-contents (package-refresh-contents))
    (mapcar
        (lambda (package)
            (unless (package-installed-p package)
                (package-install package)
            )
        )
        packages
    )
)
