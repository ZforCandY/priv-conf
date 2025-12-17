;;; pre-early-init.el --- pre_early -*- no-byte-compile: t; lexical-binding: t; -*-
(setq debug-on-error t)

;;Reducing clutter(only placed in pre-early)
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
