;;; pre-init.el --- pre_init -*- no-byte-compile: t; lexical-binding: t; -*-
(setq inferior-lisp-program "B:\\SBCL/sbcl.exe")
(windmove-default-keybindings 'shift)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

'(display-line-numbers-type (quote relative))
(column-number-mode 1)
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

(set-face-attribute 'line-number-current-line nil
                    :foreground "#FF9E3B"
                    :weight 'bold)
