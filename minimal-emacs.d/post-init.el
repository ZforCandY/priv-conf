;;; pre-init.el --- pre-init -*- no-byte-compile: t; lexical-binding: t; -*-

;; shortcut runemacs.exe --daemon (in shell:startup)
;; add EMACS_SERVER_FILE user var to "server file dir"
;; Build native-compile-emacs 31 with MSYS2(UCRT64) bash-scrpit for auto
;;(.dlls)\msys2\ucrt64\bin to path Add conpty_proxy.exe/vterm.el/vtmodule.dll to path/
;;load-path compile setq vterm-shell"powershell"
;;see(https://emacs-china.org/t/windows-emacs-libvterm/30140/20)

;;theme,font,line
(setf custom-safe-themes 't)
(setq frame-title-format nil)
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
'(global-so-long-mode t)
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'after-init-hook #'global-auto-revert-mode)
(add-hook 'after-init-hook #'recentf-mode)
(add-hook 'after-init-hook #'savehist-mode)
(add-hook 'after-init-hook #'save-place-mode)
(add-hook 'after-init-hook #'display-time-mode)
(add-hook 'after-init-hook #'window-divider-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)
(setopt display-line-numbers-width 3)
(setq scroll-conservatively 101)
(setq scroll-margin 0)
(setq scroll-preserve-screen-position t)
(setq auto-window-vscroll nil)
(setq x-stretch-cursor t)
(setq use-package-always-ensure t)
(setq initial-scratch-message "")
(setq package-install-upgrade-built-in t)
(setq inferior-lisp-program "sbcl")
(setq confirm-kill-emacs 'y-or-n-p)
'(setq fast-but-imprecise-scrolling t)
(setq redisplay-skip-fontification-on-input t)
(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setopt tab-bar-show 1
        tab-bar-close-button nil
        tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator))
(setopt mouse-autoselect-window t)
(setopt confirm-kill-processes nil)
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
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'mixed)
(global-set-key (kbd "<escape>") 'keyboard-quit)
(global-unset-key (kbd "C-x <escape> <escape>"))
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-m") #'backward-paragraph)
(global-set-key [remap list-buffers] 'ibuffer)

;;load-path
(add-to-list 'load-path "C:\\Users\\Administrator\\.emacs.d\\var\\el\\emacs-reader")
(add-to-list 'load-path "B:\\msys2\\ucrt64\\bin")
;;window-size
(add-to-list 'default-frame-alist '(width . 130))
(add-to-list 'default-frame-alist '(height . 40))
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






