;;; pre-init.el --- pre-init -*- no-byte-compile: t; lexical-binding: t; -*-

;;;Notes
;; shortcut runemacs.exe --daemon (in shell:startup)
;; add EMACS_SERVER_FILE user var to "server file dir"
;; Build native-compile-emacs 31 with MSYS2(UCRT64) bash-scrpit for auto
;;(.dlls)\msys2\ucrt64\bin to path Add conpty_proxy.exe/vterm.el/vtmodule.dll to path/
;;load-path compile setq vterm-shell"powershell"
;;see(https://emacs-china.org/t/windows-emacs-libvterm/30140/20)

;;;Selected Compile
(let ((deny-list '("\\(?:[/\\\\]\\.dir-locals\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\]modus-vivendi-theme\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\][^/\\\\]+-loaddefs\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\][^/\\\\]+-autoloads\\.el\\(?:\\.gz\\)?$\\)")))
  (setq native-comp-jit-compilation-deny-list deny-list)
  ;; Deprecated
  (with-no-warnings
    (setq native-comp-deferred-compilation-deny-list deny-list)
    (setq comp-deferred-compilation-deny-list deny-list)))
(setq native-comp-speed 2)

;;GC
                                        ;(setq gc-cons-threshold 50000000)

;;;Load-path
'(add-to-list 'load-path "C:\\Users\\Administrator\\.emacs.d\\var\\el\\emacs-reader")
(add-to-list 'load-path "B:\\msys2\\ucrt64\\bin")

;;Window-size
(add-to-list 'default-frame-alist '(fullscreen . maximized))
'(add-to-list 'default-frame-alist '(left . 150))
'(add-to-list 'default-frame-alist '(top . 50))
'(add-to-list 'default-frame-alist '(height . 40))
'(add-to-list 'default-frame-alist '(width . 60))  

;;Theme,font,line
(global-prettify-symbols-mode 1)
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

;;Defun
;change font size
(defun fsize/set-font-size (size)
  "Set font size to SIZE, specified in tenth of a point."
  (interactive "nEnter the font size: ")
  (set-face-attribute 'default nil :height size))

;;Keybind
(global-set-key (kbd "<escape>") 'keyboard-quit)
(global-unset-key (kbd "C-x <escape> <escape>"))
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-m") #'backward-paragraph)
(global-set-key (kbd "C-c l") #'inferior-lisp)
(global-set-key (kbd "C-c b") #'eval-buffer)
(define-key key-translation-map (kbd "C-q") (kbd "C-g"))
(global-set-key [remap list-buffers] 'ibuffer)

;;Windmove
(windmove-default-keybindings 'shift)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;;Configs
;;Hook
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'after-init-hook #'global-auto-revert-mode)
(add-hook 'after-init-hook #'recentf-mode)
(add-hook 'after-init-hook #'savehist-mode)
(add-hook 'after-init-hook #'save-place-mode)
(add-hook 'after-init-hook #'display-time-mode)
(add-hook 'after-init-hook #'window-divider-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)

;;Scroll
(setq scroll-conservatively 101)
(setq scroll-margin 0)
(setq scroll-preserve-screen-position t)
(setq auto-window-vscroll nil)

;;Backups
(setq make-backup-file t)
(setq vc-make-backup-files t)
(setq kept-old-versions 5)
(setq kept-new-versions 10)

;;Ensure
(setq use-package-always-ensure t)

;;Display
(setopt display-line-numbers-width 3)
(setq display-time-day-and-date t)
(setq redisplay-skip-fontification-on-input t)

;;Paren
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)

;;Cursor
(setq x-stretch-cursor t)
(setq help-window-select t)
(setq-default cursor-in-non-selected-windows nil)

;;Load
(setq load-prefer-newer t)

;;Window
(setq highlight-nonselected-windows nil)
(setopt mouse-autoselect-window t)

;;Delete
(setq delete-by-moving-to-trash t)

;;Kill
(setq confirm-kill-emacs 'y-or-n-p)
(setopt confirm-kill-processes nil)

;;Scratch
(setq initial-scratch-message "")

;;Lisp
(setq inferior-lisp-program "sbcl")
(setq inferior-lisp-program "B:\\SBCL/sbcl.exe")

;;Org
(setq org-directory "B:\\C\\org")

;;Package
(setq package-install-upgrade-built-in t)

;;Read
(setq read-process-output-max (* 1024 1024))

;;Tab-bar
(setopt tab-bar-show 1
        tab-bar-close-button nil
        tab-bar-format '(tab-bar-format-history tab-bar-format-tabs tab-bar-separator))

;;Buffer
(setopt switch-to-buffer-obey-display-actions t)

;;Server
(setq server-auth-dir "C:\\Users\\Administrator\\emacs-server-auth-dir"
      server-name "admin.txt")

;;Treesit-font
(setq treesit-font-lock-level 4)

;;Uncommented
'(setq fast-but-imprecise-scrolling t)
'(global-so-long-mode t)

;;; pre-init.el ends here
