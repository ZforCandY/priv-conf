;;; post-init.el --- post-init -*- no-byte-compile: t; lexical-binding: t; -*-
(load custom-file 'noerror 'no-message)
;;themes
                                        ;(load-theme 'grandshell t)
                                        ;(load-theme 'tomorrow-night-deepblue t)
                                        ;(use-package grandshell-theme)
                                        ;(use-package tomorrow-night-deepblue-theme)
(use-package leuven-theme)
(use-package ef-themes)

(mapc #'disable-theme custom-enabled-themes)
(add-to-list 'custom-theme-load-path "c:/Users/Administrator/.emacs.d/var/themes")
(setq custom-theme-directory "c:/Users/Administrator/.emacs.d/var/themes")
                                        ;For high light env
'(load-theme 'modus-operandi t)
'(load-theme 'leuven)
(load-theme 'modus-operandi-tinted)                                       ;For low light env
'(load-theme 'modus-vivendi-tritanopia t)
'(load-theme 'grandshell-twilly t)
                                        ;(native-comp-available-p)
;;Measure time
(defvar before-user-init-time (current-time)
  "Value of `current-time' when Emacs begins loading `user-init-file'.")
  (message "Loading Emacs...done (%.3fs)"
         (float-time (time-subtract before-user-init-time
                                    before-init-time)))
;;use-packages

(use-package vertico
  :ensure t
  :defer  t
  :hook (minibuffer-setup . vertico-repeat-save)
  :config
  (vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico--resize nil)
  (vertico--count 12))

(use-package inhibit-mouse
  :ensure t
  :config
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'inhibit-mouse-mode)
    (inhibit-mouse-mode 0)))

(use-package compile-angel
  :demand t
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

(use-package treesit-auto
  :ensure t
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
  :init
  (recentf-mode )
  :bind (("C-c f" . recentf-open-files))
  :custom
  (recentf-max-saved-items 200)
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

(use-package corfu
  :ensure t
  :commands (corfu-mode global-corfu-mode)

  :hook ((prog-mode . corfu-mode)
         (shell-mode . corfu-mode)
         (eshell-mode . corfu-mode))
  
  :custom
  (read-extended-command-predicate #'command-completion-default-include-p)
  (text-mode-ispell-word-completion nil)
  (tab-always-indent 'complete)
  :config
  (global-corfu-mode))

(use-package cape
  :ensure t
  :commands (cape-dabbrev cape-file cape-elisp-block)
  :bind ("C-c p" . cape-prefix-map)
  :init
   (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block))

(use-package org
  :ensure t
  :commands (org-mode org-version)
  :mode
  ("\\.org\\'" . org-mode)
  :custom
  (org-hide-leading-stars t)
  (org-startup-indented t)
  (org-adapt-indentation nil)
  (org-edit-src-content-indentation 0)
  ;; (org-fontify-done-headline t)
  ;; (org-fontify-todo-headline t)
  ;; (org-fontify-whole-heading-line t)
  ;; (org-fontify-quote-and-verse-blocks t)
  (org-startup-truncated t))

(use-package auto-package-update
  :ensure t
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
  :custom
    (buffer-terminator-verbose nil)
  ;; Set the inactivity timeout (in seconds) after which buffers are considered
  ;; inactive (default is 30 minutes):
  (buffer-terminator-inactivity-timeout (* 30 60)) ; 30 minutes
  ;; Define how frequently the cleanup process should run (default is every 10
  ;; minutes):
  (buffer-terminator-interval (* 10 60)) ; 10 minutes
  :config
  (buffer-terminator-mode 1))

;; Enables automatic indentation of code while typing
(use-package aggressive-indent
  :ensure t
  :commands aggressive-indent-mode
  :hook
  (c-mode . aggressive-indent-mode)
  (emacs-lisp-mode . aggressive-indent-mode)
  (lisp-mode . aggressive-indent-mode-map))

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
  :config
  (define-key paredit-mode-map (kbd "RET") nil))

(use-package avy
  :demand t
  :bind (("C-x j c" . avy-goto-char)
         ("C-x j w" . avy-goto-word-1)
         ("C-x j l" . avy-goto-line))
  :config
  (setq avy-all-windows nil
        avy-all-windows-alt t
        avy-background t
        avy-style 'pre))

(use-package reader
  :vc t
  :load-path "C:\\Users\\Administrator\\.emacs.d\\var\\el\\emacs-reader")

(use-package nov
  :defer t
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-text-widith 95))

(use-package vterm
  :load-path "C:\\Users\\Administrator\\.emacs.d\\var\\elpa"
  :bind (("C-c v t" . vterm))
  :config
  (when (eq system-type 'windows-nt)
    (setq vterm-shell "powershell")))
'(setq vterm-shell "B:\\msys2//msys2_shell.cmd -defterm -here -no-start -ucrt64 -i")

'(use-package hl-line-face
   '  :hook ((org-mode) . hl-line-mode))

(use-package display-line-numbers
  :defer t
  :hook ((prog-mode . display-line-numbers-mode)))




