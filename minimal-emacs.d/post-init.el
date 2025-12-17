;;; post-init.el --- post_init -*- no-byte-compile: t; lexical-binding: t; -*-
(use-package grandshell-theme)
(load-theme 'grandshell t)
(setq inferior-lisp-program "sbcl")
(set-face-attribute 'default nil
                    :height 139 :weight 'regular :width 'normal :foundry "outline" :family "Consolas")
