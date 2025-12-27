;;; pre-early-init.el --- pre_early -*- no-byte-compile: t; lexical-binding: t; -*-
(setq debug-on-error t)

;;Reducing clutter(only placed in pre-early)
(setq user-emacs-directory (expand-file-name "var/" minimal-emacs-user-directory))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))

;;Startup time
'(defun display-startup-time ()
   "Display the startup time and number of garbage collections."
   (message "Emacs init loaded in %.2f seconds (Full emacs-startup: %.2fs) with %d garbage collections."
            (float-time (time-subtract after-init-time before-init-time))
            (time-to-seconds (time-since before-init-time))
            gcs-done))
'(add-hook 'emacs-startup-hook #'display-startup-time 100)
