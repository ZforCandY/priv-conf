;;; post-init.el --- post-init -*- no-byte-compile: t; lexical-binding: t; -*-
                                        ;(load custom-file 'noerror 'no-message)
;;; Commentary:
;;; Code:
                                        ;(require 'cl)
;; (profiler-report)

;;Compile Angel
(use-package compile-angel
  :commands (compile-angel-on-load-mode)
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

;;Meow
(require 'meow)

;; (defun meow-config-mode ()
;;   "Mode-to-insert."
;;   ;; (cl-pushnew '(vterm-mode . insert) meow-mode-state-list)
;;   (cl-pushnew '(inferior-lisp-mode . insert) meow-mode-state-list))

(use-package meow
  ;; :demand t
  :ensure t
  :custom
  (meow-use-clipboard t)
  ;; :config (meow-config-mode)
  )

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
   '("X" . meow-till)
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
   '("]" . rf/split-window-right-and-focus)
   '("{" . split-window-below)
   '("[" . bf/split-window-below-and-focus)
   '("+" . delete-other-windows)
   ;;High frequency
   '("x" . execute-extended-command)
   '("<apps>" . "C-x C-s")
   '("M-<f9>" . "C-c g")
   '("<f9>" . se/start-emms)
   '("?" . compile)
   '("!" . previous-buffer)
   '("@" . next-buffer)
   '("#" . kill-buffer)
   '("$" . restart-emacs)
   '("Q" . "C-x C-c")
   '("C" . comment-dwim)
   '("b" . switch-to-buffer)
   '("B" . ibuffer)
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

;;themes
(mapc #'disable-theme custom-enabled-themes)
(add-to-list 'custom-theme-load-path "c:/Users/Administrator/.emacs.d/var/themes")
(setq custom-theme-directory "c:/Users/Administrator/.emacs.d/var/themes")
                                        ;For high light env
                                        ;For low light env
                                        ;naysayer-theme
                                        ;grandshell-theme
                                        ;tomorrow-night-deepblue-theme
                                        ;(load-theme 'misterioso)
(use-package leuven-theme
  :ensure t
  :config
  (load-theme 'leuven-dark t)
  :init
  (global-set-key (kbd "M-/") #'theme-choose-variant))

;; (use-package doric-themes
;;   :straight t
;;   :config
;;   (load-theme 'doric-marble t)
;;   (setq doric-themes-to-toggle '(doric-marble doric-earth))
;;   :init
;;   (global-set-key (kbd "M-/") #'doric-themes-toggle)
;;   )

;; (use-package modus-themes
;;   :ensure t
;;   :defer t
;;   :init
;;   (modus-themes-include-derivatives-mode 1)
;;   (modus-themes-load-theme 'modus-operandi)
;;   :bind
;;   (("M-/" . modus-themes-toggle)
;;    ("C-*" . modus-themes-select)
;;    ("M-*" . modus-themes-load-random))
;;   :config
;;   (setq modus-themes-to-toggle '(modus-operandi-tinted modus-operandi)
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
;;   (setq modus-themes-common-palette-overrides nil)
;;   (setq modus-themes-mode-line '(accented borderless padded))
;;   (setq modus-themes-region '(bg-only no-extend))
;;   (setq modus-themes-completions 'opinionated)
;;   (setq modus-themes-paren-match '(bold intense underline))
;;   (setq modus-themes-syntax '(alt-syntax))
;;   (setq modus-themes-headings
;;         '((1 . (rainbow overline background 1.4))
;;           (2 . (rainbow background 1.3))
;;           (3 . (rainbow bold 1.2))
;;           (t . (semilight 1.1))))
;;   (setq modus-themes-scale-headings t)
;;   (setq modus-themes-org-blocks 'gray-background))

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

;;'use-package' If :config/init/hook, then no defer.
;;W32 cut startup time trick: temp mv elpa/packages to trash, restart to test
;;time of great difference, some depen packages slow emacs greatly (but beware rm break package)
(custom-set-variables '(package-selected-packages nil))

(use-package conf-mode
  :commands (conf-mode)
  :mode
  ("\\.conf\\'" . conf-mode))

(use-package vertico
  :ensure t
  :hook (minibuffer-setup . vertico-repeat-save)
  :config
  (vertico-mode)
  :custom
  (read-buffer-completion-ignore-case t)
  (read-file-name-completion-ignore-case t)
  (completion-styles '(basic substring partial-completion flex))
  (vertico-cycle t)
  (setq vertico-resize nil)
  (setq vertico-count 12))

;; (use-package vertico-prescient
;;   :ensure t
;;   ;; (vertico-reverse-mode)
;;   :hook
;;   (after-init . vertico-prescient-mode))

(use-package vertico-posframe
  :ensure t
  :commands (execute-extended-command)
  :hook
  (after-init . vertico-posframe-mode)
  :config
  (setq vertico-posframe-parameters
        '((left-fringe . 8)
          (right-fringe . 8)))
  (setq vertico-posframe-height 11
        vertico-posframe-width 85))

;; (use-package corfu
;;   :ensure t
;;   :hook (after-init . global-corfu-mode)
;;   :config
;;   (setq corfu-auto t
;;         corfu-cycle t
;;         corfu-quit-at-boundary t
;;         corfu-quit-no-match t
;;         corfu-auto-delay 0.1
;;         corfu-auto-prefix 1))

(use-package cape
  :ensure t
  :defer t
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

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
  :commands (global-treesit-auto-mode)
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
  (setq recentf-max-saved-items 500)
  (setq recentf-max-menu-items 250)
  (recentf-case-fold-search t)
  (recentf-auto-clenanup (if (daemonp) 300 'never))
  (recentf-exclude
   (list "\\.tar$" "\\.tbz2$" "\\.tbz$" "\\.tgz$" "\\.bz2$"
         "\\.bz$" "\\.gz$" "\\.gzip$" "\\.xz$" "\\.zip$"
         "\\.7z$" "\\.rar$" "\\.pdf$"
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
  :init
  (setq savehist-autosave-interval 600
        savehist-additional-variables
        '(kill-ring extended-command-history
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
  :commands (global-company-mode)
  :config
  (setopt company-idle-delay 0
          company-minimum-prefix-length 2
          company-dabbrev-code-everywhere t
          company-dabbrev-code-other-buffers t
          company-dabbrev-code-time-limit 2
          company-show-quick-access t
          company-tooltip-offset-display 'lines
          company-tooltip-limit 10)
  (setq company-tooltip-align-annotations t
        company-require-match 'never)
  :hook
  (after-init . global-company-mode)
  )

(use-package company-dict
  :after company-box
  :straight (:build t)
  :config
  (setq company-dict-dir (expand-file-name "dicts" user-emacs-directory)))

(use-package company-box
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-show-single-candidate t
        company-box-backends-colors nil
        company-box-doc-delay 0.5
        company-box-doc-text-scale-level -2
        ))

(use-package company-prescient
  :after company
  :ensure t
  :hook
  (after-init . company-prescient-mode))

(use-package all-the-icons
  :if (display-graphic-p))

;;Org
(use-package org
  :straight t
  :defer t
  :ensure nil
  :commands (org-mode org-version)
  :mode
  ("\\.org\\'" . org-mode)
  :config
  (setq org-hide-leading-stars t
        org-startup-indented t
        org-adapt-indentation nil
        org-edit-src-content-indentation 0
        org-pretty-entities                t
        org-fontify-done-headline t
        org-fontify-todo-headline t
        org-fontify-whole-heading-line t
        org-fontify-quote-and-verse-blocks t
        org-startup-truncated t
        org-startup-align-all-tables       t
        org-src-fontify-natively t
        org-use-property-inheritance       t
        org-list-allow-alphabetical        t
        org-redisplay-inline-images        t
        org-display-inline-images          t
        org-startup-with-inline-images     "inlineimages"
        org-default-notes-file             (expand-file-name "plan.org" org-directory)
        )
  (setq org-ellipsis " ▾"
        org-hide-emphasis-markers t))

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

(use-package ibuffer
  :ensure nil
  :commands (ibuffer))

;; Ibuffer filters
(setq ibuffer-saved-filter-groups
      '(("default"
         ("org"     (or
                     (mode . org-mode)
                     (name . "^\\*Org Src")
                     (name . "^\\*Org Agenda\\*$")))
         ("tramp"   (name . "^\\*tramp.*"))
         ("emacs"   (or
                     (name . "^\\*scratch\\*$")
                     (name . "^\\*Messages\\*$")
                     (name . "^\\*Warnings\\*$")
                     (name . "^\\*Shell Command Output\\*$")
                     (name . "^\\*Async-native-compile-log\\*$")))
         ("ediff"   (name . "^\\*[Ee]diff.*"))
         ("vc"      (name . "^\\*vc-.*"))
         ("dired"   (mode . dired-mode))
         ("terminal" (or
                      (mode . vterm-mode)
                      (mode . shell-mode)
                      (mode . eshell-mode)))
         ("help"    (or
                     (name . "^\\*Help\\*$")
                     (name . "^\\*info\\*$")
                     (name . "^\\*sdcv\\*$")))
         ("media"     (or
                       (mode . emms-playlist-mode)
                       (mode . bongo-playlist-mode)
                       (name . "^\\*EMMS*\\*$")
                       (name . "^\\*Bongo\\*$")))
         ("init"     (or
                      (name . "^\\init\\.el$")
                      (name . "^\\early-init\\.el$")
                      (name . "^\\pre-early-init\\.el$")
                      (name . "^\\post-early-init\\.el$")
                      (name . "^\\pre-init\\.el$")
                      (name . "^\\post-init\\.el$")))
         )))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
(setq ibuffer-show-empty-filter-groups nil)

(use-package buffer-terminator
  :ensure t
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
  :commands aggressive-indent-mode
  :hook
  (c-mode . aggressive-indent-mode)
  (emacs-lisp-mode . aggressive-indent-mode)
  (after-init . global-aggressive-indent-mode)
  (racket-mode-hook . aggressive-indent-mode))

;; Highlights function and variable definitions in Emacs Lisp mode
(use-package highlight-defined
  :ensure t
  :commands highlight-defined-mode
  :hook
  (emacs-lisp-mode . highlight-defined-mode))

;; Prevent parenthesis imbalance
(use-package paredit
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
  :ensure t
  :commands paxedit-mode
  :hook
  (emacs-lisp-mode . paxedit-mode)
  (lisp-mode . paxedit-mode))

(use-package smartparens
  :ensure t
  :commands (smartparens-global-mode)
  :config (smartparens-global-mode)
  :hook (prog-mode text-mode emacs-lisp-mode
                   racket-mode scheme-mode common-lisp-mode
                   vterm-mode ielm-mode lisp-interaction-mode))

(with-eval-after-load 'smartparens
  (require 'smartparens-config))

(use-package elec-pair
  :ensure nil)

(use-package sly
  :commands (sly)
  )

;; (use-package magit
;;   :commands (magit)
;;   )

(use-package avy
  :ensure t
  :defer t
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

(use-package better-jumper
  :ensure t
  :commands (better-jumper-mode)
  :init
  :config
  (better-jumper-mode +1)
  (setq better-jumper-add-jump-behavior 'on-jump)
  (setq better-jumper-use-context 'window))

;;Read
;; (use-package reader
;;   :defer t
;;   :vc t
;;   :load-path "C:\\Users\\Administrator\\.emacs.d\\var\\el\\emacs-reader")

(use-package nov
  :commands (nov-mode)
  :ensure t
  :mode ("\\.epub\\'" . nov-mode)
  :bind (:map nov-mode-map
              ("b" . switch-to-buffer)
              ("d" . nov-display-metadata)
              ("x" . execute-extended-command)
              ("i" . nov-goto-toc))
  :config
  (setq nov-text-widith 95))

;; (use-package elfeed
;;   :defer t
;;   :straight (:build t)
;;   ;;:config
;;   :custom
;;   ((elfeed-db-directory  (expand-file-name ".elfeed-db"
;;                                            user-emacs-directory))))

;;Term/Shell
(use-package vterm
  :commands (vterm)
  :load-path "C:\\Users\\Administrator\\.emacs.d\\var\\elpa"
  :bind (("C-c t" . vterm))
  :init
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
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
  :commands (display-line-numbers-mode)
  :init
  (setq display-line-numbers-type (quote relative))
  :hook ((prog-mode . display-line-numbers-mode)))

(use-package ultra-scroll
  :commands (ultra-scroll-mode)
  :vc (:url "https://github.com/jdtsmith/ultra-scroll" :branch "main")
  :hook
  (after-init . ultra-scroll-mode))

(use-package golden-ratio
  :commands (golden-ratio-mode)
  :hook (after-init . golden-ratio-mode)
  :custom
  (golden-ratio-auto-scale t))

(defun my-which-key-sort (a b)
  "Custom sort function to prioritize letters A B over numbers."
  (let ((key-a (car a))
        (key-b (car b)))
    (if (and (string-match-p "[a-zA-Z]" (char-to-string (aref key-a 0)))
             (not (string-match-p "[a-zA-Z]" (char-to-string (aref key-b 0)))))
        -1
      (if (and (not (string-match-p "[a-zA-Z]" (char-to-string (aref key-a 0))))
               (string-match-p "[a-zA-Z]" (char-to-string (aref key-b 0))))
          1
        (string< (char-to-string (aref key-a 0)) (char-to-string (aref key-b 0)))))))

(use-package which-key
  :ensure nil
  :commands (which-key-mode)
  :hook
  (after-init . which-key-mode)
  :config
  (setq which-key-side-window-location 'bottom
        which-key-sort-uppercase-first nil
        which-key-sort-order #'my-which-key-sort
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.1
        which-key-page-delay 0.1
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit t
        which-key-separator " -> "))

(use-package marginalia
  :ensure t
  :commands (marginalia-mode)
  :custom
  (marginalia-max-relative-age 0)
  (marginalia--align 'right)
  :init
  (add-hook 'minibuffer-setup-hook #'marginalia-mode))

(use-package orderless
  :ensure t
  :straight t
  :defer t
  :after vertico
  :init
  (setq completion-styles '(orderless basic)
        orderless-matching-styles '(orderless-literal orderless-regexp)
        completion-category-defaults nil
        completion-category-overrides nil)
  )

(use-package dired
  :ensure nil
  :commands (dired)
  :hook
  ((dired-mode . dired-hide-details-mode)
   (dired-mode . hl-line-mode))
  :config
  ;;(dired-recursive-copies 'always)
  ;;(dired-recursive-deletes 'always)
  ;;(setq dired-kill-when-opening-new-dired-buffer t)
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches "-alh"))

(use-package dired-subtree
  :commands (dired-subtree-toggle)
  :bind
  ( :map dired-mode-map
    ("<tab>" . dired-subtree-toggle)
    ("TAB" . dired-subtree-toggle)
    ("<backtab>" . dired-subtree-remove)
    ("S-TAB" . dired-subtree-remove))
  :config
  (setq dired-subtree-use-backgrounds nil))

;; (use-package bufler
;;   :ensure t
;;   :straight (bufler :build t)
;;   :after dired
;;   :bind (:map
;;          bufler-list-mode-map
;;          ("g" .  bufler)
;;          ("f" .  bufler-list-group-frame)
;;          ("F" .  bufler-list-group-make-frame)
;;          ("N" .  bufler-list-buffer-name-workspace)
;;          ("D" .  bufler-list-buffer-kill)
;;          ("p" .  bufler-list-buffer-peek)
;;          ("<apps>" .  bufler-list-buffer-save)
;;          ("RET" . bufler-list-buffer-switch)))

;;nerd-icons

(use-package nerd-icons
  :after dired
  :ensure t)

(use-package nerd-icons-dired
  :ensure t
  :after nerd-icons
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; (use-package nerd-icons-completion
;;   :after marginalia
;;   :config
;;   (nerd-icons-completion-mode)
;;   (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-ibuffer
  :ensure t
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode)
  :init
  (setq nerd-icons-ibuffer-human-readable-size t)
  (setq inhibit-compacting-font-caches t))

(use-package flycheck
  :ensure t
  :commands (global-flycheck-mode)
  :hook (after-init . global-flycheck-mode)
  :config
  (setq flycheck-idle-change-delay 2.0)
  (delq 'new-line flycheck-check-syntax-automatically)
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (setq flycheck-display-errors-delay 0.2)
  (add-hook 'c-mode-common-hook #'flycheck-mode)
  )

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

(use-package ispell
  ;;See https://rbrins.com/posts/2023-01-08-installing-spellcheck-emacs.html
  :commands (ispell-region)
  :ensure nil
  :config
  (setenv "LANG" "en_US")
  (setq ispell-program-name "B:/Hunspell/bin/hunspell.exe")
  (setq ispell-quietly t)
  (setq flyspell-issue-welcome-flag nil)
  (setq flyspell-issue-message-flag nil)
  (setq ispell-dictionary "en_US")
  (setq ispell-local-dictionary "en_US")
  (setq ispell-extra-args '("-d" "en_US"))
  (setq ispell-local-dictionary-alist
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))
  (setq ispell-hunspell-dictionary-alist
        '(("en_US"
           "C:/Hunspell/en_US/en_US.aff"
           "C:/Hunspell/en_US/en_US.dic"
           nil nil nil "utf-8"))))

(use-package rainbow-delimiters
  :commands (rainbow-delimiters-mode)
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
  :after meow
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
  :ensure t
  :commands stripspace-local-mode
  :hook ((prog-mode . stripspace-local-mode)
         (text-mode . stripspace-local-mode)
         (conf-mode . stripspace-local-mode))
  :custom
  (stripspace-only-if-initially-clean nil)
  (stripspace-restore-column t))

;;Image
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

(use-package isearch
  :ensure nil
  :config
  (setq isearch-lazy-count t)
  (setq lazy-count-prefix-format "(%s/%s) ")
  (setq lazy-count-suffix-format nil)
  (setq search-whitespace-regexp ".*?"))

(progn ;    `isearch'
  (setq isearch-allow-scroll nil))

(use-package eieio
  :defer t
  :config
  (setq eieio-backward-compatibility t))

(use-package helpful
  :ensure t
  :defer 5)

(use-package powershell
  :ensure t
  :commands (powershell-mode)
  :mode
  ("\\.ps1\\'" . powershell-mode))

;; (use-package geiser-guile
;;   :defer t
;;   :mode ("\\.guile\\'" . scheme-mode))

(use-package sicp
  :commands (info))

(use-package racket-mode
  :commands (racket-mode)
  :mode
  ("\\.scm\\'" . racket-mode))

;; (use-package clojure-mode
;;   :defer t
;;   :mode
;;   ("\\.clj\\'" . clojure-mode))

(use-package ahk-mode
  :commands (ahk-mode)
  :mode
  ("\\.ahk\\'" . ahk-mode))

;; (use-package asm-mode
;;   :defer t
;;   :mode
;;   ("\\.asm\\'" . asm-mode)
;;   :config
;;   (setq asm-comment-char ?#))

;;Dictionary
(setq dictionary-server "dict.org")
(use-package quick-sdcv
  :ensure t
  :commands (quick-sdcv-search-at-point)
  :bind (:map quick-sdcv-mode-map
              ("q" . quit-window))
  :custom
  (quick-sdcv-dictionary-prefix-symbol "►")
  (quick-sdcv-ellipsis " ▼")
  :config
  (setq quick-sdcv-unique-buffers nil)
                                        ;(setq quick-sdcv-exact-search t)
  (setq quick-sdcv-hist-size 100)
  (add-hook 'quick-sdcv-mode-hook #'goto-address-mode)
  )

(use-package doc-view
  :commands (doc-view-mode)
  )
                                        ;(doc-view-ghostscript-program
                                        ;"B:/gs10.06.0/bin/gswin64c.exe")
;;ripgrep
;; (use-package rg
;;   :commands (rg)
;;   :bind
;;   (("C-c r" . rg))
;;   :config
;;   (setq rg-w32-unicode t))

(use-package deadgrep
  :commands (deadgrep))

(with-eval-after-load 'inhibit-mouse
  (progn
    (setq isearch-allow-scroll 'unlimited)
    (setq isearch-lazy-count t)
                                        ;(require 'rg-isearch)
                                        ;(define-key isearch-mode-map "\M-sr" 'rg-isearch-menu)
    ))

;;media
(use-package emms
  :ensure t
  :commands (emms)
  :straight (:build t)
  :init
  (setq emms-source-file-default-directory (expand-file-name "E://Music"))
  :bind
  (:map emms-playlist-mode-map
        ("M-<f1>" . emms-stop)
        ("M-<f2>" . emms-start)
        ("M-<f6>" . emms-pause)
        ("M-<f5>" . emms-previous)
        ("M-<f7>" . emms-next)
        ("r" . emms-random)
        ("i" . emms-insert-directory)
        ("l" . emms-lyrics-lrclib-get)
        ("M-l" . emms-lyrics-toggle-display-on-minibuffer)
        ("b" . emms-lyrics-toggle-display-buffer)
        ("M-D" . quit-window)
        ("q" . emms-pause)
        ("s" . emms-show)
        ("M-," . emms-seek-backward)
        ("M-." . emms-seek-forward)
        ("D" . emms-playlist-clear)
        ("S" . emms-playlist-save)
        ("A" . emms-playlist-sort-by-natural-order)
        ("R" . emms-playlist-sort-by-random)
        )
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-cache-enable)
  (require 'emms-tag-editor)
  (require 'emms-info-native)
  (setq emms-info-functions '(emms-info-native))
  (setq emms-tag-editor-tagfile-functions
        '(("mp3" . emms-info-native)
          ("ogg" . emms-info-native)
          ("wav" . emms-info-native)
          ("flac" . emms-info-native)))
  (setq emms-player-list '(emms-player-mplayer)
        emms-info-asynchronously t
        emms-source-file-directory-tree-function 'emms-source-file-directory-tree-find
        emms-last-played-format-alist '(((t) . "%H:%M "))
        emms-show-format "🎧 Now: %s"
        emms-lyrics-display-buffer t
        emms-lyrics-scroll-p nil
        emms-playlist-mode-center-when-go t
        emms-lyrics-display-on-modeline nil
        emms-lyrics-display-on-minibuffer t
        emms-playlist-buffer-name "*EMMS*"
        )
  )

(with-eval-after-load 'emms
  (progn
    (emms-lyrics 1)
    (cl-pushnew '(emms-playlist-mode . insert) meow-mode-state-list)))

(defun se/start-emms ()
  "Start emms with meow-insert."
  (interactive)
  (emms)
  (emms-playing-time 1)
  (meow-insert)
  )

;;Also check 'customize-group'
(use-package bongo
  :ensure t
  :commands (bongo-playlist)
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

  (defun bongo-playlist-random-toggle ()
    "Toggle `bongo-random-playback-mode' in playlist buffers."
    (interactive)
    (if (eq bongo-next-action 'bongo-play-random-or-stop)
        (bongo-progressive-playback-mode)
      (bongo-random-playback-mode)))

  :bind (:map bongo-playlist-mode-map
              ("h" . bongo-undo)
              ("q" . bongo-redisplay)
              ("M-D" . bongo-quit)
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
              ("s" . bongo-play-previous)
              ("x" . bongo-play-next)
              ("r" . bongo-play-random)
              ("R" . bongo-playlist-random-toggle)
              ("M-I" . bongo-insert-special)
              )) ;mplayer

(defun bf/bongo-fix-mpv ()
  "Temporarily ignore mpv 'error cause by 'windows-nt (prevent Debugger entered)."
  (interactive)
  (when (string-equal (buffer-name) "*Bongo Playlist*")
    (add-to-list 'debug-ignored-errors 'error)
    ))

(add-hook 'bongo-playlist-mode-hook 'bf/bongo-fix-mpv)

;; (defun bf1/bongo-fix-ignore ()
;;   "Remove 'error' from 'debug-ignored-errors'."
;;   (interactive)
;;   (setopt debug-ignored-errors
;;           '(beginning-of-line
;;             beginning-of-buffer end-of-line
;;             end-of-buffer end-of-file buffer-read-only
;;             file-supersession mark-inactive user-error)))

;;'Error' running timer ‘bongo-mpv-player-tick’: ('error' "Unknown address family")

(defun bf2/fix-echo ()
  "Suppress disgusting 'error' message spam in the echo area."
  (interactive)
  (defadvice message (around my-message-filter activate)
    (unless (string-match "Error running timer" (or (ad-get-arg 0) ""))
      ad-do-it)))

(add-hook 'bongo-playlist-mode-hook 'bf2/fix-echo)

;;media ends here

;; (use-package eros
;;   :ensure t
;;   :commands (eros-mode)
;;   :config (eros-mode))

(use-package eww
  :ensure nil
  :commands (eww)
  :straight (:type built-in)
  :bind (:map eww-mode-map
              ("b" . switch-to-buffer)
              ("x" . execute-extended-command)
              )
  :config
  (setq eww-auto-rename-buffer 'title))

(use-package centered-cursor-mode
  :ensure t
  :after meow
  :config
  (global-centered-cursor-mode))

(use-package focus
  :commands (focus-mode))

(global-set-key (kbd "C-<f12>") 'focus-mode)

(use-package goggles
  :hook ((prog-mode-hook . goggles-mode)
         (text-mode-hook . goggles-mode))
  :config
  (setq-default goggles-pulse t))

(use-package vundo
  :ensure t
  :bind (("C-c u" . vundo))
  :commands vundo
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols
        vundo-window-side 'bottom
        vundo-max-column 60))

(use-package crux
  :defer t
  )

(use-package webjump
  :ensure nil
  :commands (webjump)
  :custom
  (webjump-sites
   '(("DuckDuckGo" . [simple-query "www.duckduckgo.com" "www.duckduckgo.com/?q=" ""])
     ("Google" . [simple-query "www.google.com" "www.google.com/search?q=" ""])
     ("YouTube" . [simple-query "www.youtube.com/feed/subscriptions" "www.youtube.com/results?search_query=" ""])
     )))

;; (USE-package keyfreq
;;   :hook
;;   (after-init . keyfreq-mode)
;;   :config
;;   (keyfreq-autosave-mode))

;; (use-package dash
;;   :defer 5)
;; (eval-after-load "dash" '(dash-enable-font-lock))

;; (use-package transient
;;   :disabled t
;;   :ensure nil)

(use-package casual-suite
  :defer 5
  :bind ("C-o" . casual-editkit-main-tmenu)
  :bind (("C-c v a" . casual-avy-tmenu))
  )

(use-package restart-emacs
  :ensure t
  :defer t
  :commands (restart-emacs))

;;Defun misc. Cool or Useful elisp 'func' I found
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

(defun jp/jump-paren (arg)
  "If on left parenthesis then jump to right. Vice versa 'ARG'."
  (interactive "^p")
  (cond
   ((looking-at "\\s\(")
    (forward-list 1))
   ((looking-at "\\s\)")
    (forward-char 1)
    (backward-list 1))
   (t (message "No parenthesis."))))

(global-set-key (kbd "C-<apps>") 'jp/jump-paren)

(with-current-buffer (get-buffer-create "*scratch*")
  (message (format "┌┬┐┬ ┬┬
 │ ││││
 ┴ └┴┘┴
      ┬  ┬┌─┐┬ ┬┌┬┐
      │  ││ ┬├─┤ │
      ┴─┘┴└─┘┴ ┴ ┴
                ┌─┐┌─┐┌─┐┬─┐┬┌─┬ ┌─┐
                └─┐├─┘├─┤├┬┘├┴┐│ ├┤
                └─┘┴  ┴ ┴┴└─┴ ┴┴─└─┘
Only when you creating you truly alive.

Loading time: %s
Packages: %s

"                  (emacs-init-time)
(number-to-string (length package-activated-list)))))

(provide 'post-init)
;;; post-init.el ends here
