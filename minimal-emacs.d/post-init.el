;;; post-init.el --- post-init -*- no-byte-compile: t; lexical-binding: t; -*-
                                        ;(load custom-file 'noerror 'no-message)
;;; Commentary:
;;; Code:
                                        ;(require 'cl)
                                        ;(profiler-report)

;;Compile Angel
(use-package compile-angel
  :defer 1
  :ensure t
  :custom
  (compile-angel-verbose t)
  :config
  (push "/init.el" compile-angel-excluded-files)
  (push "/early-init.el" compile-angel-excluded-files)
  (push "/pre-init.el" compile-angel-excluded-files)
  (push "/post-init.el" compile-angel-excluded-files)
  (push "/pre-early-init.el" compile-angel-excluded-files)
  (push "/post-early-init.el" compile-angel-excluded-files)
  (compile-angel-on-load-mode 1))

;;themes
(mapc #'disable-theme custom-enabled-themes)
(add-to-list 'custom-theme-load-path "c:/Users/Administrator/.emacs.d/var/themes")
(setq custom-theme-directory "c:/Users/Administrator/.emacs.d/var/themes")
                                        ;For high light env
                                        ;For low light env
                                        ;naysayer-theme
                                        ;grandshell-theme
                                        ;tomorrow-night-deepblue-theme
(use-package leuven-theme
  :ensure t
  :config
  (load-theme 'leuven t)
  :init
  (global-set-key (kbd "M-/") #'theme-choose-variant))

;; (use-package modus-themes
;;   :ensure t
;;   :defer t
;;   :init
;;   (modus-themes-include-derivatives-mode 1)
;;   (modus-themes-load-theme 'modus-operandi-tinted)
;;   :bind
;;   (("M-/" . modus-themes-toggle)
;;    ("C-*" . modus-themes-select)
;;    ("M-*" . modus-themes-load-random))
;;   :config
;;   (setq modus-themes-to-toggle '(modus-vivendi-tinted modus-operandi-tinted)
;;         modus-themes-to-rotate modus-themes-items
;;         modus-themes-mixed-fonts t
;;         modus-themes-variable-pitch-ui t
;;         modus-themes-italic-constructs t
;;         modus-themes-bold-constructs t
;;         modus-themes-completions '((t . (bold)))
;;         modus-themes-prompts '(bold)
;;         modus-themes-headings
;;         '((agenda-structure . (variable-pitch light 2.2))
;;           (agenda-date . (variable-pitch regular 1.3))
;;           (t . (regular 1.15))))
;;   (setq modus-themes-common-palette-overrides nil))

                                        ;(native-comp-available-p)
:Straight.el
(straight-use-package 'use-package)

;;Measure time
(defvar before-user-init-time (current-time)
  "Value of `current-time' when Emacs begins loading `user-init-file'.")
(message "Loading Emacs...done (%.3fs)"
         (float-time (time-subtract before-user-init-time
                                    before-init-time)))

;;Daemon
(defun ss/server-start ()
  "Start daemon based on 'server-running-p'."
  (interactive)
  (cond
   ((unless (server-running-p))(server-start))
   ((eq (server-running-p) t) (message server-name))
   (t (server-start))))

(use-package server
  ;;:defer 2
  :commands (server-running-p)
  :init (ss/server-start))

(set-frame-parameter nil 'fullscreen 'fullboth)

;;Meow
(require 'meow)

(defun meow-config-mode ()
  "Mode-to-insert."
  (cl-pushnew '(vterm-mode . insert) meow-mode-state-list)
  (cl-pushnew '(inferior-lisp-mode . insert) meow-mode-state-list))

(use-package meow
  :ensure t
  :custom
  (meow-use-clipboard t)
  :config (meow-config-mode))

(defun meow-setup ()
  "Meow-setup."
  (setq meow-cheatsheet-physical-layout meow-cheatsheet-physical-layout-ansi)
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  ;;Digits
  (meow-leader-define-key
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("-" . meow-keypad-describe-key)
   '("_" . meow-cheatsheet))
  (meow-normal-define-key
   ;;Basic move
   '("i" . meow-prev)
   '("k" . meow-next)
   '("j" . meow-left)
   '("l" . meow-right)
   ;;Expand move
   '("I" . meow-prev-expand)
   '("K" . meow-next-expand)
   '("J" . meow-left-expand)
   '("L" . meow-right-expand)
   ;;Expand
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   ;;Word&symbol
   '("u" . meow-back-word)
   '("o" . meow-next-word)
   '("U" . meow-back-symbol)
   '("O" . meow-next-symbol)
   ;;Selected command
   '("s" . meow-visit)
   '("S" . meow-goto-line)
   '("p" . meow-cancel-selection)
   '("P" . meow-pop-selection)
   '("y" . meow-find)
   '("x" . meow-till)
   '("/" . meow-quit)
   '("a" . meow-mark-word)
   '("A" . meow-mark-symbol)
   '("e" . meow-line)
   '("E" . meow-block)
   '("m" . meow-reverse)
   ;;Undo&redo
   '("h" . undo-only)
   '("H" . undo-redo)
   ;;Edit
   '("d" . meow-delete)
   '("D" . meow-kill)
   '("f" . meow-change)
   '("v" . meow-yank)
   '("V" . meow-replace)
   '("c" . meow-save) ;;copy
   '("g" . meow-grab)
   '("G" . meow-sync-grab)
   ;;Insert
   '("w" . meow-insert)
   '("r" . meow-open-above)
   '("R" . meow-open-below)
   '("n" . meow-join)
   '("N" . meow-append)
   ;;Thing
   '("," . meow-beginning-of-thing)
   '("." . meow-end-of-thing)
   '(";" . meow-inner-of-thing)
   '(":" . meow-bounds-of-thing)
   ;;Line
   '("z" . open-line)
   '("Z" . split-line)
   ;;Indent
   '("-" . indent-rigidly-left-to-tab-stop)
   '("=" . indent-rigidly-right-to-tab-stop)
   ;;Windows
   '("}" . split-window-right)
   '("{" . split-window-below)
   '("+" . delete-other-windows)
   ;;High frequency
   '("<apps>" . "C-x C-s")
   '("<f9>" . "C-c g")
   '("?" . compile)
   '("!" . previous-buffer)
   '("@" . next-buffer)
   '("$" . kill-buffer)
   '("Q" . "C-x C-c")
   '("C" . comment-dwim)
   '("b" . switch-to-buffer)
   '("M" . imenu)
   '("F" . toggle-frame-fullscreen)
   ;;Misc
   '("<escape>" . ignore)
   '("`" . repeat)
   ))

(setq meow-use-cursor-position-hack t)
(setq meow-update-interval 0.05)
(setq meow-esc-delay 0.001)
(setq meow-cursor-type-insert '(bar . 4))

(meow-setup)
(unless (bound-and-true-p meow-global-mode)
  (meow-global-mode 1))
(meow-global-mode 1)

(add-hook 'find-file-hook
          (lambda ()
            (when (> (buffer-size) 1048576)
              (setq-local meow-highlight-selection nil))))

;;Meow config ends here

;;use-packages If config/init/hook then no defer
(custom-set-variables '(package-selected-packages nil))

(use-package conf-mode
  :defer t
  :mode
  ("\\.conf\\'" . conf-mode))

(use-package vertico
  :defer 3
  :ensure t
  :hook (minibuffer-setup . vertico-repeat-save)
  :config
  (vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico--resize nil)
  (vertico--count 12))

(use-package vertico-prescient
  :ensure t
  :after vertico
  :hook
  (after-init . vertico-prescient-mode))

(use-package inhibit-mouse
  :after server
  :custom
  (inhibit-mouse-adjust-mouse-highlight t)
  (inhibit-mouse-adjust-show-help-function t)
  :config
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'inhibit-mouse-mode)
    (inhibit-mouse-mode 1)))

(use-package treesit-auto
  :ensure t
  :defer 3
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package autorevert
  :ensure nil
  :commands (auto-revert-mode global-auto-revert-mode)
  :hook
  (after-init . global-auto-revert-mode)
  :custom
  (auto-revert-interval 3)
  (auto-revert-remote-file nil)
  (auto-revert-use-notify t)
  (auto-revert-avoid-polling nil)
  (auto-revert-verbose t))

;; Enable `auto-save-mode' to prevent data loss. Use `recover-file' or
;; `recover-session' to restore unsaved changes.
(setq auto-save-default t)
(setq auto-save-interval 300)
(setq auto-save-timeout 30)
(setq auto-save-visited-interval 5)   ; Save after 5 seconds if inactivity
(auto-save-visited-mode 1)

(use-package recentf
  :ensure nil
  :commands (recentf-mode recentf-cleanup)
  :hook
  (after-init . recentf-mode)
  :bind (("C-c f" . recentf-open-files))
  :custom
  (setq recentf-max-saved-items 200)
  (setq recentf-max-menu-items 15)
  (recentf-case-fold-search t)
  (recentf-auto-clenanup (if (daemonp) 300 'never))
  (recentf-exclude
   (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
         "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
         "\\.7z$" "\\.rar$"
         "COMMIT_EDITMSG\\'"
         "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
         "-autoloads\\.el$" "autoload\\.el$"))
  :config
  (add-hook 'kill-emacs-hook #'recentf-cleanup -90))

(use-package savehist
  :ensure nil
  :commands (savehist-mode savehist-save)
  :hook
  (after-init . savehist-mode)
  :custom
  (savehist-autosave-interval 600)
  (savehist-additional-variables
   '(kill-ring
     register-alist
     mark-ring global-mark-ring
     search-ring regexp-search-ring)))

(use-package saveplace
  :ensure nil
  :commands (save-place-mode save-place-local-mode)
  :hook
  (after-init . save-place-mode)
  :custom
  (save-place-limit 400))

(use-package company
  :ensure t
  :hook
  (after-init . global-company-mode)
  :init
  (setopt company-idle-delay 0
          company-minimum-prefix-length 2)
  (setopt company-dabbrev-code-everywhere t)
  (setopt company-dabbrev-code-other-buffers t
          company-dabbrev-code-time-limit 2)
  (setopt company-show-quick-access t
          company-tooltip-offset-display 'lines
          company-tooltip-limit 10))

(use-package company-box
  :after all-the-icons
  :hook (company-mode . company-box-mode))

(use-package company-prescient
  :after company
  :ensure t
  :hook
  (after-init . company-prescient-mode))

(use-package all-the-icons
  :after company
  :if (display-graphic-p))

(use-package org
  :defer t
  :ensure t
  :commands (org-mode org-version)
  :mode
  ("\\.org\\'" . org-mode)
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-adapt-indentation nil)
  (org-edit-src-content-indentation 0)
  (org-fontify-done-headline t)
  (org-fontify-todo-headline t)
  (org-fontify-whole-heading-line t)
  (org-fontify-quote-and-verse-blocks t)
  (org-startup-truncated t)
  (org-src-fontify-natively t))

;; (use-package auto-package-update
;;   :ensure t
;;   :defer 5
;;   :custom
;;   ;; Here, packages will only be updated if at least 7 days have passed
;;   ;; since the last successful update.
;;   (auto-package-update-interval 7)
;;   (auto-package-update-hide-results t)
;;   (auto-package-update-delete-old-versions t)
;;   :config
;;   ;; Run package updates automatically at startup, but only if the configured
;;   ;; interval has elapsed.
;;   (auto-package-update-maybe)
;;   (auto-package-update-at-time "7:30"))

(use-package buffer-terminator
  :ensure t
  :defer 3
  :custom
  (buffer-terminator-verbose nil)
  ;; Set the inactivity timeout (in seconds) after which buffers are considered
  ;; inactive (default is 30 minutes):
  (buffer-terminator-inactivity-timeout (* 30 60)) ; 30 minutes
  ;; Define how frequently the cleanup process should run (default is every 10
  ;; minutes):
  (buffer-terminator-interval (* 10 60)) ; 10 minutes
  :hook
  (after-init . buffer-terminator-mode))

;; Enables automatic indentation of code while typing
(use-package aggressive-indent
  :ensure t
  :defer 3
  :commands aggressive-indent-mode
  :hook
  (c-mode . aggressive-indent-mode)
  (emacs-lisp-mode . aggressive-indent-mode)
  (after-init global-aggressive-indent-mode))

;; Highlights function and variable definitions in Emacs Lisp mode
(use-package highlight-defined
  :ensure t
  :defer 3
  :commands highlight-defined-mode
  :hook
  (emacs-lisp-mode . highlight-defined-mode))

;; Prevent parenthesis imbalance

(use-package paredit
  :defer 3
  :ensure t
  :commands paredit-mode
  :hook
  (emacs-lisp-mode . paredit-mode)
                                        ;(lisp-mode . paredit-mode)
  (common-lisp-mode . paredit-mode)
  (scheme-mode . paredit-mode)
  (racket-mode . paredit-mode)
  :config
  (define-key paredit-mode-map (kbd "RET") nil))

(defun tp/toggle-paredit ()
  "Toggle paredit modes with Lisp dialets mode."
  (interactive)
  (cond
   ((not paredit-mode)(setq paredit-mode 1))
   ((paredit-mode)(setq paredit-mode nil))
   ))
(global-set-key (kbd "<f4>") 'tp/toggle-paredit)

(use-package paxedit
  :defer 3
  :ensure t
  :commands paxedit-mode
  :hook
  (emacs-lisp-mode . paxedit-mode)
  (lisp-mode . paxedit-mode))

(use-package smartparens
  :ensure t
  :after paredit
  :hook (prog-mode text-mode emacs-lisp-mode
                   racket-mode scheme-mode common-lisp-mode
                   vterm-mode))

(with-eval-after-load 'smartparens
  (require 'smartparens-config))

(use-package sly
  :defer t
  )

;; (use-package magit
;;   :defer t
;;   )

(use-package avy
  :defer 5
  :bind (("C-c v c" . avy-goto-char)
         ("C-c v w" . avy-goto-word-1)
         ("C-c v l" . avy-goto-line)
         ("C-c v e" . avy-goto-end-of-line))
  :config
  (setq avy-all-windows nil
        avy-all-windows-alt t
        avy-background t
        avy-style 'pre)
  :custom
  (avy-timeout-seconds 0.3)
  (setq avy-case-fold-search nil
        (setq avy-indent-line-overlay t)))

;; (use-package reader
;;   :defer t
;;   :vc t
;;   :load-path "C:\\Users\\Administrator\\.emacs.d\\var\\el\\emacs-reader")

(use-package nov
  :defer 10
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-text-widith 95))

(use-package vterm
  :defer 3
  :load-path "C:\\Users\\Administrator\\.emacs.d\\var\\elpa"
  :bind (("C-c t" . vterm))
  :init
  (setq vterm-copy-exclude-prompt nil)
  (setq vterm-always-compile-module t)
  (setq vterm-timer-delay 0.01)
  (setq vterm-max-scrollback 20000)
  :config
  (when (eq system-type 'windows-nt)
    (setq vterm-shell "powershell")))

(defun vm/vterm-mouse ()
  "Vterm enable mouse."
  (interactive)
  (if (string-equal (buffer-name) "*vterm*")
      (inhibit-mouse-mode 0)
    (inhibit-mouse-mode 1))
  )

(add-hook 'fundamental-mode 'vterm-mode)
;;(setq vterm-shell "B:\\msys2//msys2_shell.cmd -defterm -here -no-start -ucrt64 -i")

(use-package display-line-numbers
  :defer 3
  :init
  (setq display-line-numbers-type (quote relative))
  :hook ((prog-mode . display-line-numbers-mode)))

(use-package ultra-scroll
  :vc (:url "https://github.com/jdtsmith/ultra-scroll" :branch "main")
  :hook
  (after-init . ultra-scroll-mode))

(use-package golden-ratio
  :diminish golden-ratio-mode
  :hook (after-init . golden-ratio-mode)
  :custom
  (golden-ratio-auto-scale t))

(use-package which-key
  :hook
  (after-init . which-key-mode))

(use-package marginalia
  :ensure t
  :custom
  (marginalia-max-relative-age 0)
  (marginalia--align 'right)
  :hook (after-init . marginalia-mode))

(use-package orderless
  :defer 5
  :ensure t
  :custom
  (completing-styles '(orderles basic))
  (orderless-matching-styles '(orderless-literal orderless-regexp))
  (completion-category-defaults nil)
  (completing-category-overrides nil))

(use-package dired
  :defer 5
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches "-alh"))

(use-package dired-subtree
  :defer 6
  :after dired
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

;;nerd-icons

(use-package nerd-icons
  :after dired
  :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :after nerd-icons
  :hook
  (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode)
  :init
  (setq nerd-icons-ibuffer-human-readable-size t)
  (setq inhibit-compacting-font-caches t))

(use-package flycheck
  :ensure t
  :hook (after-init . global-flycheck-mode))

(use-package flyover
  :ensure t
  :after flycheck
  :hook ((flycheck-mode . flyover-mode)
         (flymake-mode . flyover-mode))
  :custom
  (flyover-checkers '(flycheck flymake))
  (flyover-levels '(error warning info))
  (flyover-use-theme-colors t)
  (flyover-background-lightness 60)
  (flyover-info-icon "ⓘ")
  (flyover-warning-icon "⚠︎")
  (flyover-error-icon "❌")
  (flyover-border-style 'arrow)
  (flyover-show-virtual-line t)
  (flyover-virtual-line-type 'curved-dotted-arrow)
  (flyover-line-position-offset 1)
  (flyover-wrap-messages t)
  (flyover-max-line-length 80)
  (flyover-debounce-interval 0.2)
  (flyover-cursor-debounce-interval 0.3)
  (flyover-display-mode 'always)
  (flyover-hide-during-completion t))

(use-package rainbow-delimiters
  :defer 3
  :hook ((prog-mode . rainbow-delimiters-mode))
  :init
  (with-eval-after-load 'rainbow-delimiters
    (set-face-foreground 'rainbow-delimiters-depth-1-face "#c66")  ; red
    (set-face-foreground 'rainbow-delimiters-depth-2-face "#6c6")  ; green
    (set-face-foreground 'rainbow-delimiters-depth-3-face "#69f")  ; blue
    (set-face-foreground 'rainbow-delimiters-depth-4-face "#cc6")  ; yellow
    (set-face-foreground 'rainbow-delimiters-depth-5-face "#6cc")  ; cyan
    (set-face-foreground 'rainbow-delimiters-depth-6-face "#c6c")  ; magenta
    (set-face-foreground 'rainbow-delimiters-depth-7-face "#ccc")  ; light gray
    (set-face-foreground 'rainbow-delimiters-depth-8-face "#999")  ; medium gray
    (set-face-foreground 'rainbow-delimiters-depth-9-face "#666")) ; dark gray
  )

(use-package expreg
  :defer 2
  :config (global-set-key (kbd "M-j") 'expreg-expand))

;; (use-package org-bullets
;;   :defer 15
;;   :after org
;;   :hook (org-mode-hook . org-bullets-mode))
(setq org-startup-truncated nil)

(use-package simple-modeline
  :init
  (setq simple-modeline-segments
        '((simple-modeline-segment-modified
           simple-modeline-segment-buffer-name
           simple-modeline-segment-position)
          (
           ;;simple-modeline-segment-minor-modes
           simple-modeline-segment-input-method
           simple-modeline-segment-eol
           simple-modeline-segment-encoding
           simple-modeline-segment-vc
           simple-modeline-segment-misc-info
           simple-modeline-segment-process
           simple-modeline-segment-major-mode)))
  :hook (after-init . simple-modeline-mode))

(use-package stripspace
  :defer 5
  :ensure t
  :commands stripspace-local-mode
  :hook ((prog-mode . stripspace-local-mode)
         (text-mode . stripspace-local-mode)
         (conf-mode . stripspace-local-mode))
  :custom
  (stripspace-only-if-initially-clean nil)
  (stripspace-restore-column t))

;; (straight-use-package '(org-yt
;;                         :type git
;;                         :host github
;;                         :repo "TobiasZawada/org-yt"
;;                         :ensure t
;;                         :defer t
;;                         :defer 10))
                                        ;(require 'org-yt)


                                        ;(org-link-set-parameters "http"  :image-data-fun #'org-http-image-data-fn)
                                        ;(org-link-set-parameters "https" :image-data-fun #'org-http-image-data-fn)
(progn ;    `isearch'
  (setq isearch-allow-scroll nil))

(use-package eieio
  :defer t)

(use-package helpful
  :ensure t
  :defer 5)

'(use-package powershell
   :defer t
   :ensure )

(use-package geiser-guile
  :defer t
  :mode ("\\.guile\\'" . scheme-mode))

(use-package sicp
  :after racket-mode)

(use-package racket-mode
  :defer t
  :mode
  ("\\.scm\\'" . racket-mode))

(use-package quick-sdcv
  :ensure t
  :defer t
  :custom
  (quick-sdcv-dictionary-prefix-symbol "►")
  (quick-sdcv-ellipsis " ▼")
  :init
  (setq quick-sdcv-unique-buffers nil)
                                        ;(setq quick-sdcv-exact-search t)
  (setq quick-sdcv-hist-size 100)
  (add-hook 'quick-sdcv-mode-hook #'goto-address-mode)
  )

(use-package doc-view
  :defer t
  )
                                        ;(doc-view-ghostscript-program
                                        ;"B:/gs10.06.0/bin/gswin64c.exe")
;;ripgrep
(use-package rg
  :defer t
  :bind
  (("C-c r" . rg))
  :config
  (setq rg-w32-unicode t))

(with-eval-after-load 'rg
  (require 'rg-isearch)
  (define-key isearch-mode-map "\M-sr" 'rg-isearch-menu))

;;media
(use-package bongo
  :ensure t
  :defer t
  :config
  (setq bongo-logo nil)
  (setq bongo-display-track-icons nil)
  (setq bongo-display-header-icons t)
  (setq bongo-display-inline-playback-progress t)
  (setq bongo-mark-played-tracks t)
  (setq bongo-field-separator (propertize " . " 'face 'shadow))
  (setq bongo-default-directory "E:/Music/")
  (setq bongo-insert-whole-directory-trees t)
  (setq bongo-prefer-library-buffers nil)
  (setq bongo-display-track-lengths t)
  (setq bongo-display-playback-mode-indicator t)
  (setq bongo-display-inline-playback-progress t)
  (setq bongo-header-line-mode t)
  (setq bongo-mode-line-indicator-mode t)
  (setq bongo-enabled-backends '(mpv)) ;mpv/mplayer
  ;;; Bongo playlist buffer
  (defvar prot/bongo-playlist-delimiter
    "\n******************************\n\n"
    "Delimiter for inserted items in `bongo' playlist buffers.")

  (defun prot/bongo-playlist-section ()
    (bongo-insert-comment-text
     prot/bongo-playlist-delimiter))

  (defun prot/bongo-paylist-section-next ()
    "Move to next `bongo' playlist custom section delimiter."
    (interactive)
    (let ((section "^\\*+$"))
      (if (save-excursion (re-search-forward section nil t))
          (progn
            (goto-char (point-at-eol))
            (re-search-forward section nil t))
        (goto-char (point-max)))))

  (defun prot/bongo-paylist-section-previous ()
    "Move to previous `bongo' playlist custom section delimiter."
    (interactive)
    (let ((section "^\\*+$"))
      (if (save-excursion (re-search-backward section nil t))
          (progn
            (goto-char (point-at-bol))
            (re-search-backward section nil t))
        (goto-char (point-min)))))

  (defun prot/bongo-playlist-mark-section ()
    "Mark `bongo' playlist section, delimited by custom markers.
The marker is `prot/bongo-playlist-delimiter'."
    (interactive)
    (let ((section "^\\*+$"))
      (search-forward-regexp section nil t)
      (push-mark nil t)
      (forward-line -1)
      ;; REVIEW any predicate to replace this `save-excursion'?
      (if (save-excursion (re-search-backward section nil t))
          (progn
            (search-backward-regexp section nil t)
            (forward-line 1))
        (goto-char (point-min)))
      (activate-mark)))

  (defun prot/bongo-playlist-kill-section ()
    "Kill `bongo' playlist-section at point.
This operates on a custom delimited section of the buffer.  See
`prot/bongo-playlist-kill-section'."
    (interactive)
    (prot/bongo-playlist-mark-section)
    (bongo-kill))

  (defun prot/bongo-playlist-play-random ()
    "Play random `bongo' track and determine further conditions."
    (interactive)
    (unless (bongo-playlist-buffer)
      (bongo-playlist-buffer))
    (when (or (bongo-playlist-buffer-p)
              (bongo-library-buffer-p))
      (unless (bongo-playing-p)
        (with-current-buffer (bongo-playlist-buffer)
          (bongo-play-random)
          (bongo-random-playback-mode 1)
          (bongo-recenter)))))

  (defun prot/bongo-playlist-random-toggle ()
    "Toggle `bongo-random-playback-mode' in playlist buffers."
    (interactive)
    (if (eq bongo-next-action 'bongo-play-random-or-stop)
        (bongo-progressive-playback-mode)
      (bongo-random-playback-mode)))

  (defun prot/bongo-playlist-reset ()
    "Stop playback and reset `bongo' playlist marks.
To reset the playlist is to undo the marks produced by non-nil
`bongo-mark-played-tracks'."
    (interactive)
    (when (bongo-playlist-buffer-p)
      (bongo-stop)
      (bongo-reset-playlist)))

  (defun prot/bongo-playlist-terminate ()
    "Stop playback and clear the entire `bongo' playlist buffer.
Contrary to the standard `bongo-erase-buffer', this also removes
the currently-playing track."
    (interactive)
    (when (bongo-playlist-buffer-p)
      (bongo-stop)
      (bongo-erase-buffer)))

  (defun prot/bongo-playlist-insert-playlist-file ()
    "Insert contents of playlist file to a `bongo' playlist.
Upon insertion, playback starts immediately, in accordance with
`prot/bongo-play-random'.

The available options at the completion prompt point to files
that hold filesystem paths of media items.  Think of them as
'directories of directories' that mix manually selected media
items.

Also see `prot/bongo-dired-make-playlist-file'."
    (interactive)
    (let* ((path "E:/Music/")
           (dotless directory-files-no-dot-files-regexp)
           (playlists (mapcar
                       'abbreviate-file-name
                       (directory-files path nil dotless)))
           (choice (completing-read "Insert playlist: " playlists nil t)))
      (if (bongo-playlist-buffer-p)
          (progn
            (save-excursion
              (goto-char (point-max))
              (bongo-insert-playlist-contents
               (format "%s%s" path choice))
              (prot/bongo-playlist-section))
            (prot/bongo-playlist-play-random))
        (user-error "Not in a `bongo' playlist buffer"))))

;;; Bongo + Dired (bongo library buffer)
  (defmacro prot/bongo-dired-library (name doc val)
    "Create `bongo' library function NAME with DOC and VAL."
    `(defun ,name ()
       ,doc
       (when (string-match-p "\\`E:/Music/" default-directory)
         (bongo-dired-library-mode ,val))))

  (prot/bongo-dired-library
   prot/bongo-dired-library-enable
   "Set `bongo-dired-library-mode' when accessing ~/Music.

Add this to `dired-mode-hook'.  Upon activation, the directory
and all its sub-directories become a valid library buffer for
Bongo, from where we can, among others, add tracks to playlists.
The added benefit is that Dired will continue to behave as
normal, making this a superior alternative to a purpose-specific
library buffer.

Note, though, that this will interfere with `wdired-mode'.  See
`prot/bongo-dired-library-disable'."
   1)

  ;; NOTE `prot/bongo-dired-library-enable' does not get reactivated
  ;; upon exiting `wdired-mode'.
  ;;
  ;; TODO reactivate bongo dired library upon wdired exit
  (prot/bongo-dired-library
   prot/bongo-dired-library-disable
   "Unset `bongo-dired-library-mode' when accessing ~/Music.
This should be added `wdired-mode-hook'.  For more, refer to
`prot/bongo-dired-library-enable'."
   -1)

  (defun prot/bongo-dired-insert-files ()
    "Add files in a `dired' buffer to the `bongo' playlist."
    (let ((media (dired-get-marked-files)))
      (with-current-buffer (bongo-playlist-buffer)
        (goto-char (point-max))
        (mapc 'bongo-insert-file media)
        (prot/bongo-playlist-section))
      (with-current-buffer (bongo-library-buffer)
        (dired-next-line 1))))

  (defun prot/bongo-dired-insert ()
    "Add `dired' item at point or marks to `bongo' playlist.

The playlist is created, if necessary, while some other tweaks
are introduced.  See `prot/bongo-dired-insert-files' as well as
`prot/bongo-playlist-play-random'.

Meant to work while inside a `dired' buffer that doubles as a
library buffer (see `prot/bongo-dired-library')."
    (interactive)
    (when (bongo-library-buffer-p)
      (unless (bongo-playlist-buffer-p)
        (bongo-playlist-buffer))
      (prot/bongo-dired-insert-files)
      (prot/bongo-playlist-play-random)))

  (defun prot/bongo-dired-make-playlist-file ()
    "Add `dired' marked items to playlist file using completion.

These files are meant to reference filesystem paths.  They ease
the task of playing media from closely related directory trees,
without having to interfere with the user's directory
structure (e.g. a playlist file 'rock' can include the paths of
~/Music/Scorpions and ~/Music/Queen).

This works by appending the absolute filesystem path of each item
to the selected playlist file.  If no marks are available, the
item at point will be used instead.

Selecting a non-existent file at the prompt will create a new
entry whose name matches user input.  Depending on the completion
framework, such as with `icomplete-mode', this may require a
forced exit (e.g. \\[exit-minibuffer] to parse the input without
further questions).

Also see `prot/bongo-playlist-insert-playlist-file'."
    (interactive)
    (let* ((dotless directory-files-no-dot-files-regexp)
           (pldir "E:/Music/")
           (playlists (mapcar
                       'abbreviate-file-name
                       (directory-files pldir nil dotless)))
           (plname (completing-read "Select playlist: " playlists nil nil))
           (plfile (format "%s/%s" pldir plname))
           (media-paths
            (if (derived-mode-p 'dired-mode)
                ;; TODO more efficient way to do ensure newline ending?
                ;;
                ;; The issue is that we need to have a newline at the
                ;; end of the file, so that when we append again we
                ;; start on an empty line.
                (concat
                 (mapconcat #'identity
                            (dired-get-marked-files)
                            "\n")
                 "\n")
              (user-error "Not in a `dired' buffer"))))
      ;; The following `when' just checks for an empty string.  If we
      ;; wanted to make this more robust we should also check for names
      ;; that contain only spaces and/or invalid characters…  This is
      ;; good enough for me.
      (when (string-empty-p plname)
        (user-error "No playlist file has been specified"))
      (unless (file-directory-p pldir)
        (make-directory pldir))
      (unless (and (file-exists-p plfile)
                   (file-readable-p plfile)
                   (not (file-directory-p plfile)))
        (make-empty-file plfile))
      (append-to-file media-paths nil plfile)
      (with-current-buffer (find-file-noselect plfile)
        (delete-duplicate-lines (point-min) (point-max))
        (sort-lines nil (point-min) (point-max))
        (save-buffer)
        (kill-buffer))))
;;;kbd that make sense
  :hook ((dired-mode-hook . prot/bongo-dired-library-enable)
         (wdired-mode-hook . prot/bongo-dired-library-disable))
  :bind (:map bongo-playlist-mode-map
              ("h" . bongo-undo)
              ("d" . bongo-recenter)
              ("<f2>" . bongo-pause/resume)
              ("n" . bongo-next)
              ("p" . bongo-previous)
              ("<f1>" . bongo-start/stop)
              ("c" . bongo-mark-region)
              ("v" . bongo-kill-marked)
              ("D" . bongo-delete-played-tracks)
              ("a" . bongo-next-object)
              ("w" . bongo-previous-object)
              ("M-a" . prot/bongo-paylist-section-next)
              ("M-w" . prot/bongo-paylist-section-previous)
              ;; ("M-m" . prot/bongo-playlist-mark-section)
              ;;("M-d" . prot/bongo-playlist-kill-section)
              ("s" . bongo-play-previous)
              ("x" . bongo-play-next)
              ("M-r" . prot/bongo-playlist-reset)
              ;; ("D" . prot/bongo-playlist-terminate)
              ("r" . bongo-play-random)
              ("R" . prot/bongo-playlist-random-toggle)
              ;;("R" . bongo-rename-line)
              ;;("l" . bongo-dired-line)       ; Jump to dir of file at point
              ;;("J" . dired-jump)             ; Jump to library buffer
              ;;("I" . prot/bongo-playlist-insert-playlist-file)
              ("M-I" . bongo-insert-special)
              :map bongo-dired-library-mode-map
              ("<C-return>" . prot/bongo-dired-insert)
              ("C-c SPC" . prot/bongo-dired-insert)
              ("C-c +" . prot/bongo-dired-make-playlist-file))) ;mplayer

(defun bf/bongo-fix-mpv ()
  "Temporarily ignore mpv 'error cause by 'windows-nt (prevent Debugger entered)."
  (interactive)
  (when (string-equal (buffer-name) "*Bongo Playlist*")
    (add-to-list 'debug-ignored-errors 'error)
    ))

(add-hook 'bongo-playlist-mode-hook 'bf/bongo-fix-mpv)

(defun bf1/bongo-fix-ignore ()
  "Remove 'error from 'debug-ignored-errors."
  (interactive)
  (setopt debug-ignored-errors
          '(beginning-of-line
            beginning-of-buffer end-of-line
            end-of-buffer end-of-file buffer-read-only
            file-supersession mark-inactive user-error)))

;;(timer--function) "C-c h" jump to src
;;'Error' running timer ‘bongo-mpv-player-tick’: (error "Unknown address family")

(defun bf2/fix-echo ()
  "Suppress-disgusting'Error'message spam on echo area."
  (interactive)
  (defadvice message (around my-message-filter activate)
    (unless (string-match "Error running timer" (or (ad-get-arg 0) ""))
      ad-do-it)))

(add-hook 'bongo-playlist-mode-hook 'bf2/fix-echo)

;;media ends here

(use-package eros
  :ensure t
  :defer t
  :config (eros-mode 1))

;;defun misc
(defun toggle-mode-line ()
  "Toggles the modeline on and off."
  (interactive)
  (setq mode-line-format
        (if (equal mode-line-format nil)
            (default-value 'mode-line-format)) )
  (redraw-display))

(global-set-key [f12] 'toggle-mode-line)

(defun jump-middle ()
  "Jump to the middle of the line."
  (interactive)
  (let*
      (
       (begin (line-beginning-position))
       (end (line-end-position))
       (middle (/ (+ end begin) 2))
       )
    (goto-char middle))
  )

(global-set-key (kbd "C-<return>") 'jump-middle)

(defun www/search-website ()
  "Browse url."
  (interactive)
  (browse-url (concat "https://search.marginalia.nu/search?profile=yolo&js=no-js&query="
                      (read-string "Search: "))))
(provide 'post-init)
;;; post-init.el ends here
