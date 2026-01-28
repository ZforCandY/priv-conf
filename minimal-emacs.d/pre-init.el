;;; post-init.el --- post-init -*- no-byte-compile: t; lexical-binding: t; -*-
                                        ;(load custom-file 'noerror 'no-message)
;;; Commentary:
;;; Code:

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

'(use-package modus-themes
   :ensure t
   :defer t
   :init
   (modus-themes-include-derivatives-mode 1)
   (modus-themes-load-theme 'modus-operandi-tinted)
   :bind
   (("M-/" . modus-themes-toggle)
    ("C-*" . modus-themes-select)
    ("M-*" . modus-themes-load-random))
   :config
   (setq modus-themes-to-toggle '(modus-vivendi-tinted modus-operandi-tinted)
         modus-themes-to-rotate modus-themes-items
         modus-themes-mixed-fonts t
         modus-themes-variable-pitch-ui t
         modus-themes-italic-constructs t
         modus-themes-bold-constructs t
         modus-themes-completions '((t . (bold)))
         modus-themes-prompts '(bold)
         modus-themes-headings
         '((agenda-structure . (variable-pitch light 2.2))
           (agenda-date . (variable-pitch regular 1.3))
           (t . (regular 1.15))))
   (setq modus-themes-common-palette-overrides nil))

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
  (interactive "")
  (cond ((eq (server-running-p) t) (message server-name))
        ((unless (server-running-p))(server-start))
        (t (server-start))))

(use-package server
  :defer 2
  :commands (server-running-p))

(set-frame-parameter nil 'fullscreen 'fullboth)
(ss/server-start)

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
  :defer 3
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
  :ensure t
  :defer t
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
  (org-startup-truncated t))

'(use-package auto-package-update
   :ensure t
   :defer 5
   :custom
   ;; Here, packages will only be updated if at least 7 days have passed
   ;; since the last successful update.
   (auto-package-update-interval 7)
   (auto-package-update-hide-results t)
   (auto-package-update-delete-old-versions t)
   :config
   ;; Run package updates automatically at startup, but only if the configured
   ;; interval has elapsed.
   (auto-package-update-maybe)
   (auto-package-update-at-time "7:30"))

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

  (use-package paxedit
    :defer 3
    :ensure t
    :commands paxedit-mode
    :hook
    (emacs-lisp-mode . paxedit-mode)
    (lisp-mode . paxedit-mode))

(use-package sly
  :defer t)

'(use-package magit
   :defer t
   )

(use-package avy
  :defer 5
  :bind (("C-x j c" . avy-goto-char)
         ("C-x j w" . avy-goto-word-1)
         ("C-x j l" . avy-goto-line)
         ("C-x j e" . avy-goto-end-of-line))
  :config
  (setq avy-all-windows nil
        avy-all-windows-alt t
        avy-background t
        avy-style 'pre)
  :custom
  (avy-timeout-seconds 0.3)
  (setq avy-case-fold-search nil
        (setq avy-indent-line-overlay t)))

'(use-package reader
   :defer t
   :vc t
   :load-path "C:\\Users\\Administrator\\.emacs.d\\var\\el\\emacs-reader")

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

                                        ;(setq vterm-shell "B:\\msys2//msys2_shell.cmd -defterm -here -no-start -ucrt64 -i")

(use-package display-line-numbers
  :defer 3
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

'(use-package org-bullets
   :defer 15
   :after org
   :hook (org-mode-hook . org-bullets-mode))
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

'(straight-use-package '(org-yt
                         :type git
                         :host github
                         :repo "TobiasZawada/org-yt"
                         :ensure t
                         :defer t
                         :defer 10))
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
  :defer t)

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

;;defun misc
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

(provide 'post-init)
;;; post-init.el ends here
