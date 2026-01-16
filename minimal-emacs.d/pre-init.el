;;; pre-init.el --- pre-init -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:
;; shortcut runemacs.exe --daemon (in shell:startup)
;; add EMACS_SERVER_FILE user var to "server file dir"
;; Build native-compile-emacs 31 with MSYS2(UCRT64) bash-scrpit for auto
;; (.dlls)\msys2\ucrt64\bin to path Add conpty_proxy.exe/vterm.el/vtmodule.dll to path/
;; load-path compile setq vterm-shell"powershell"
;; see(https://emacs-china.org/t/windows-emacs-libvterm/30140/20)
;; add.dlls kiennq/treesit-langs to treesits

;;; Code:
(require 'use-package)
(setq use-package-compute-statistics t)

;;Selected Compile
(let ((deny-list '("\\(?:[/\\\\]\\.dir-locals\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\]modus-vivendi-theme\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\][^/\\\\]+-loaddefs\\.el\\(?:\\.gz\\)?$\\)"
                   "\\(?:[/\\\\][^/\\\\]+-autoloads\\.el\\(?:\\.gz\\)?$\\)")))
  (setq native-comp-jit-compilation-deny-list deny-list)
  ;; Deprecated
  (with-no-warnings
    (setq native-comp-deferred-compilation-deny-list deny-list)
    (setq comp-deferred-compilation-deny-list deny-list)))

(setq package-native-compile t)
(setq compile-angel-enable-byte-compile t)
(setq compile-angel-enable-native-compile t)
(defvar old-value nil)
(defvar original-noninteractive-value nil)
(setq native-comp-speed 3)
(setq native-comp-async-query-on-exit t)
(setq confirm-kill-processes t)
(setq native-comp-compiler-options '("-march=znver3" "-Ofast" "-g0" "-fno-finite-math-only" "-fgraphite-identity" "-floop-nest-optimize" "-fdevirtualize-at-ltrans" "-fipa-pta" "-fno-semantic-interposition" "-flto=auto" "-fuse-linker-plugin"))

(setq native-comp-driver-options '("-march=znver3" "-Ofast" "-g0" "-fno-finite-math-only" "-fgraphite-identity" "-floop-nest-optimize" "-fdevirtualize-at-ltrans" "-fipa-pta" "-fno-semantic-interposition" "-flto=auto" "-fuse-linker-plugin"))

;;GC
                                        ;(setq gc-cons-threshold 50000000)

;;Load-path
                                        ;(add-to-list 'load-path "C:\\Users\\Administrator\\.emacs.d\\var\\el\\emacs-reader")
(add-to-list 'load-path "B:\\msys2\\ucrt64\\bin")
(load (concat (file-name-directory user-init-file) "buffer-move.el"))

                                        ;(add-to-list 'load-path "C:\\Users\\Administrator\\.emacs.d\\var/4g.el")
                                        ;(load (concat (file-name-directory user-init-file) "4g.el"))

;;Window-size
(set-frame-parameter nil 'fullscreen 'fullboth)
;(add-to-list 'default-frame-alist '(fullscreen . maximized))
                                        ;(add-to-list 'default-frame-alist '(left . 150))
                                        ;(add-to-list 'default-frame-alist '(top . 50))
                                        ;(add-to-list 'default-frame-alist '(height . 40))
                                        ;(add-to-list 'default-frame-alist '(width . 160))

;;Center-window
'(defun center-frame ()
   "Center the frame on the screen, respecting the size set in 'default-frame-alist'."
   (interactive)
   (let* ((desired-width
           (or (cdr (assq 'width default-frame-alist)) 80))
          (desired-height
           (or (cdr (assq 'height default-frame-alist)) 24))
          (screen-width (x-display-pixel-width))
          (screen-height (x-display-pixel-height))
          (char-width (frame-char-width))
          (char-height (frame-char-height))
          (frame-pixel-width (* desired-width char-width))
          (frame-pixel-height (* desired-height char-height))
          (left (max 0 (/ (- screen-width frame-pixel-width) 2)))
          (top (max 0 (/ (- screen-height frame-pixel-height) 2))))
     (set-frame-size (selected-frame) desired-width desired-height)
     (set-frame-position (selected-frame) left top)
     ))
'(add-hook 'window-setup-hook #'center-frame)

;;Straight bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;Straight config
(setq straight-vc-git-default-clone-depth 1)

;;Theme,font,line
(global-prettify-symbols-mode 1)
(setf custom-safe-themes 't)
(setq frame-title-format "λ: %b")

(set-face-attribute 'default nil
                    :height 139 :weight 'regular :width 'normal :foundry "outline" :family "Consolas")
'(setq mode-line-position-column-line-format '("%l:%C"))
'(display-line-numbers-type (quote relative))
(column-number-mode 1)

'(when (version<= "26.0.50" emacs-version)
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
(fsize/set-font-size 200)

;;Keybind
(global-set-key (kbd "<escape>") 'keyboard-quit)
(global-unset-key (kbd "C-x <escape> <escape>"))
(global-set-key (kbd "M-n") #'forward-paragraph)
(global-set-key (kbd "M-m") #'backward-paragraph)
(global-set-key (kbd "C-c l") #'inferior-lisp)
                                        ;(global-set-key (kbd "C-c b") #'eval-buffer)
(global-set-key (kbd "C-c e") #'eval-last-sexp)
(global-set-key (kbd "M-<up>") #'backward-sexp)
(global-set-key (kbd "C-c i") #'info-other-window)
(define-key key-translation-map (kbd "C-q") (kbd "C-g"))
(global-set-key [remap list-buffers] 'ibuffer)
(global-set-key (kbd "C-c s") #'bookmark-set)
(global-set-key (kbd "C-c b") #'bookmark-jump)
(global-set-key (kbd "C-c m") #'imenu)

;;Helpful
(global-set-key (kbd "C-h f") #'helpful-function)
(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h c") #'helpful-command)
(global-set-key (kbd "C-c h") #'helpful-at-point)

;;Paxedit
(global-set-key (kbd "M-d") #'paxedit-delete)

;;sexp
(global-set-key (kbd "M-<up>") #'backward-sexp)
(global-set-key (kbd "M-<down>") #'forward-sexp)

;;Windmove
(windmove-default-keybindings 'shift)
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;Buffmove
(global-set-key (kbd "C-<up>")     'buf-move-up)
(global-set-key (kbd "C-<down>")   'buf-move-down)
(global-set-key (kbd "C-<left>")   'buf-move-left)
(global-set-key (kbd "C-<right>")  'buf-move-right)
;;;Configs
;;Hook
(add-hook 'text-mode-hook 'visual-line-mode)
                                        ;(add-hook 'after-init-hook #'global-auto-revert-mode)
                                        ;(add-hook 'after-init-hook #'recentf-mode)
                                        ;(add-hook 'after-init-hook #'savehist-mode)
                                        ;(add-hook 'after-init-hook #'save-place-mode)
(add-hook 'after-init-hook #'display-time-mode)
(add-hook 'after-init-hook #'window-divider-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'prog-mode-hook 'electric-pair-mode)
(add-hook 'after-init-hook #'minibuffer-depth-indicate-mode)

;;Scroll
(setq scroll-conservatively 101)
(setq scroll-margin 0)
(setq scroll-preserve-screen-position t)
(setq auto-window-vscroll nil)

;;Sly
(setq sly-lisp-implementations
      '((sbcl ("sbcl" "noinform") :coding-system utf-8-unix)
        (ccl ("wx86cl64.exe"))))

;;Flycheck
(setq flycheck-display-errors-delay 0.1)
(setq flycheck-debug t)

;;Backups
(setq make-backup-file t)
(setq vc-make-backup-files t)
(setq kept-old-versions 5)
(setq kept-new-versions 10)

;;Ensure
(setq use-package-always-ensure t)

;;Env
(set-language-environment "UTF-8")

;;Performance
(setq inhibit-compacting-font-cache t)
(setenv "LSP_USE_PLISTS" "true")
(setq lsp-use-plists t)
(setq package-quickstart t)
(setq frame-resize-pixelwise t)

;;Display
(setopt display-line-numbers-width 3)
                                        ;(setq display-time-day-and-date t)
(setq redisplay-skip-fontification-on-input t)

;;Paren
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'mixed)

;;Cursor
(setq x-stretch-cursor t)
(setq help-window-select t)
(setq-default cursor-in-non-selected-windows nil)

;;Company

;;Mouse
(setq mouse-wheel-scroll-amount '(2 ((shift) . 1)) ;; one line at a time
      mouse-wheel-progressive-speed nil ;; don't accelerate scrolling
      mouse-wheel-follow-mouse 't ;; scroll window under mouse
      )

;;Default
(setq-default lexical-binding t)

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
(setq initial-scratch-message "┌┬┐┬ ┬┬
 │ ││││
 ┴ └┴┘┴
      ┬  ┬┌─┐┬ ┬┌┬┐
      │  ││ ┬├─┤ │
      ┴─┘┴└─┘┴ ┴ ┴
                ┌─┐┌─┐┌─┐┬─┐┬┌─┬ ┌─┐
                └─┐├─┘├─┤├┬┘├┴┐│ ├┤
                └─┘┴  ┴ ┴┴└─┴ ┴┴─└─┘
")

;;Lisp
(setq inferior-lisp-program "sbcl")
(setq inferior-lisp-program "B:\\SBCL/sbcl.exe")

;;Org
(setq org-directory "B:\\C\\org")
                                        ;(setq org-startup-numerated t)
(setq org-hide-leading-stars t)
(setq org-fontify-quote-and-verse-blocks t)

;;Inline-image
'(defun org-http-image-data-fn (protocol link _description)
   "Interpret LINK as an URL to an image file."
   (when (and (image-type-from-file-name link)
              (not (eq org-display-remote-inline-images 'skip)))
     (if-let (buf (url-retrieve-synchronously (concat protocol ":" link)))
         (with-current-buffer buf
           (goto-char (point-min))
           (re-search-forward "\r?\n\r?\n" nil t)
           (buffer-substring-no-properties (point) (point-max)))
       (message "Download of image \"%s\" failed" link)
       nil)))

(setq org-display-remote-inline-images 'cache)

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
(modify-frame-parameters nil '((inhibit-double-buffering . nil)))
(setq frame-inhibit-implied-resize t)

;;Server
(setq server-auth-dir "C:\\Users\\Administrator\\emacs-server-auth-dir"
      server-name "admin.txt")
                                        ;(server-running-p)

;;Treesit-font
(setq treesit-font-lock-level 4)

;;Custom.el
'(add-hook 'after-init-hook (lambda ()
                              (let ((inhibit-message t))
                                (when (file-exists-p custom-file)
                                  (load-file custom-file)))))
(setq custom-file nil)

;;Uncommented
                                        ;(setq fast-but-imprecise-scrolling t)
                                        ;(global-so-long-mode t)

;;; pre-init.el ends here
