;;; pre-init.el --- pre-init -*- no-byte-compile: t; lexical-binding: t; -*-

;; shortcut runemacs.exe --daemon (in shell:startup)
;; add EMACS_SERVER_FILE user var to "server file dir"
;; Build native-compile-emacs 31 with MSYS2(UCRT64) bash-scrpit for auto
;;(.dlls)\msys2\ucrt64\bin to path Add conpty_proxy.exe/vterm.el/vtmodule.dll to path/
;;load-path compile setq vterm-shell"powershell"
;;see(https://emacs-china.org/t/windows-emacs-libvterm/30140/20)

;;theme,font,line
(set-face-attribute 'default nil
                    :height 139 :weight 'regular :width 'normal :foundry "outline" :family "Consolas")

(setq mode-line-position-column-line-format '("%l:%C"))
'(display-line-numbers-type (quote relative))
(column-number-mode 1)
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))
(set-face-attribute 'line-number-current-line nil
                    :foreground "#FFFFFF"
                    :weight 'bold)
                                        ;change font size
(defun fsize/set-font-size (size)
  "Set font size to SIZE, specified in tenth of a point."
  (interactive "nEnter the font size: ")
  (set-face-attribute 'default nil :height size))

;;configs
(setq initial-scratch-message "")
(setq package-install-upgrade-built-in t)
(setq inferior-lisp-program "sbcl")
(setq confirm-kill-emacs 'y-or-n-p)
(add-hook 'after-init-hook #'display-time-mode)
(add-hook 'after-init-hook #'window-divider-mode)
(setq fast-but-imprecise-scrolling t)
(setopt mouse-autoselect-window t)
(setopt switch-to-buffer-obey-display-actions t)
(setq load-prefer-newer t)
(setq org-directory "B:\\C\\org")
 (setq inferior-lisp-program "B:\\SBCL/sbcl.exe")
(windmove-default-keybindings 'shift)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(setq server-auth-dir "C:\\Users\\Administrator\\emacs-server-auth-dir"
      server-name "admin.txt")
(setq treesit-font-lock-level 4)
;;load-path
(add-to-list 'load-path "C:\\Users\\Administrator\\.emacs.d\\var\\el\\emacs-reader")
(add-to-list 'load-path "B:\\msys2\\ucrt64\\bin")
;;selected compile
(let ((deny-list '("\\(?:[/\\\\]\\.dir-locals\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\]modus-vivendi-theme\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\][^/\\\\]+-loaddefs\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\][^/\\\\]+-autoloads\\.el\\(?:\\.gz\\)?$\\)")))
  (setq native-comp-jit-compilation-deny-list deny-list)
  ;; Deprecated
  (with-no-warnings
    (setq native-comp-deferred-compilation-deny-list deny-list)
    (setq comp-deferred-compilation-deny-list deny-list)))


