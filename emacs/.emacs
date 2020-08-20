(prefer-coding-system 'utf-8)
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

; (require 'benchmark-init)
; ; To disable collection of benchmark data after init is done.
; (add-hook 'after-init-hook 'benchmark-init/deactivate)

; (setq initial-frame-alist '((top . 53) (left . 245) (width . 140) (height . 50)))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq frame-resize-pixelwise t)
(setq-default line-spacing 0.2)
(set-face-attribute 'default nil :family "Go Mono" :height 120)
(set-face-attribute 'variable-pitch nil :family "Public Sans" :height 140)
(set-face-attribute 'fixed-pitch nil :family "Go Mono")
(add-to-list 'default-frame-alist
                       '(font . "Go Mono-12:regular"))
(setq-default indent-tabs-mode nil)
(setq c-default-style "linux"
                       c-basic-offset 4)
(setq scroll-conservatively 10000)
(setq scroll-margin 4)
; (global-set-key (kbd "C-x g") 'magit-status)

; (require 'evil-magit)

; (require 'powerline)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d0fe9efeaf9bbb6f42ce08cd55be3f63d4dfcb87601a55e36c3421f2b5dc70f3" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "11e57648ab04915568e558b77541d0e94e69d09c9c54c06075938b6abc0189d8" default)))
 '(doom-modeline-height 15)
 '(evil-search-module (quote evil-search))
 '(helm-ag-base-command "rg --no-heading")
 '(helm-completion-style (quote emacs))
 '(markdown-header-scaling t)
 '(markdown-header-scaling-values (quote (1.7 1.5 1.2 1.0 1.0 1.0)))
 '(org-export-backends (quote (ascii beamer html icalendar latex md)))
 '(package-selected-packages
   (quote
    (org-re-reveal helm-xref dumb-jump dumb-diff rust-mode sass-mode ox-tufte doom-themes org-mu4e ox-twbs evil-org use-package-ensure-system-package evil-collection org-bullets load-theme-buffer-local dashboard helm-projectile projectile all-the-icons-dired doom-modeline poet-theme deadgrep benchmark-init esup helm-ag helm-rg php-boris-minor-mode php-mode phps-mode cider gnu-elpa-keyring-update evil-magit magit yaml-mode go-mode color-theme-sanityinc-tomorrow visual-fill-column olivetti solidity-mode rainbow-delimiters racket-mode powerline seti-theme dracula-theme sublime-themes orgalist molokai-theme evil))))

(eval-when-compile
  (require 'use-package))
(use-package use-package-ensure-system-package
  :ensure t)
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dracula t)
  (doom-themes-visual-bell-config))
; (use-package dracula-theme
;   :ensure t)
(use-package olivetti
  :config
  (setq olivetti-body-width 120)
  :ensure t)
(use-package deadgrep
  :init (defalias 'rg 'deadgrep)
  :ensure t
  :ensure-system-package (rg . ripgrep))
(use-package all-the-icons
  :ensure t)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode)
  :ensure t)
(use-package poet-theme
  :defer t
  :ensure t)
(use-package projectile
  :config
  (setq projectile-completion-system 'helm)
  (helm-projectile-on)
  :bind ("C-c p" . 'projectile-command-map)
  :ensure t)
(use-package dumb-jump
  :config
  (setq dumb-jump-prefer-searcher 'rg)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :ensure t)
(use-package go-mode
  :bind (:map go-mode-map
              ("C-c C-j" . nil))
  :ensure t)
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :ensure t
  ; :custom (evil-collection-setup-minibuffer t)
  :init
  (evil-collection-init))
(use-package evil-org
  :ensure t
  :after org
  :config
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 1.5))
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package helm
  :ensure t
  :init
  (helm-mode 1)
  :bind (("C-x C-f" . helm-find-files)
         ("C-x b"   . helm-mini)
         ("C-h a"   . helm-apropos)))

(use-package helm-config
  :init
  (global-set-key (kbd "C-c h") 'helm-command-prefix))

(use-package helm-xref
  :ensure t)


(use-package visual-fill-column
  :ensure t)
(use-package markdown-mode
  :mode "\\.md\\'"
  :ensure t)
(use-package org
  :init
  (defalias 'oc 'org-capture)
  (defalias 'oa (lambda (&optional arg) (interactive "P")(org-agenda arg "t")))
  :mode ("\\.org\\'" . org-mode)
  :config
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-verbatim nil :inherit 'fixed-pitch)
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)")
                            (sequence "|" "CANCELLED(c)")))
  (setq org-log-done 'time)
  (setq org-archive-location (concat org-directory "/done.org_archive::datetree/"))
  (setq org-default-notes-file (concat org-directory "/todo.org"))
  (setq org-agenda-files '("~/org"))
  (setq org-export-time-stamp-file nil)
  (setq org-export-with-toc nil)
  (setq org-export-with-section-numbers nil)
  (setq org-export-with-author nil)
  :ensure t)
(use-package ox-twbs
  :after org
  :ensure t)
(use-package ox-tufte
  :after org
  :ensure t)
(use-package org-re-reveal
  :after org
  :custom
  (org-re-reveal-root "file:///home/atharva/reveal")
  (org-re-reveal-revealjs-version "4")
  (org-re-reveal-transition "slide")
  :ensure t)
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :ensure t)
(use-package racket-mode
  :mode "\\.rkt\\'"
  :ensure t)
(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode racket-mode) . rainbow-delimiters-mode)
  :ensure t)
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :ensure t)

(use-package magit
  :commands magit-status
  :bind ("C-x g" . 'magit-status))
(use-package evil-magit
  :ensure t
  :after magit
  :demand t)

;; MAIL
(use-package mu4e
  ;; use mu4e for e-mail in emacs
  :after mu4e-context
  :ensure nil
  :ensure-system-package mu
  :init
  (setq mu4e-maildir (expand-file-name "~/.mail"))
  (setq mail-user-agent 'mu4e-user-agent)
  (setq mu4e-user-mail-address-list '("raykar.ath@gmail.com" "pesos@pes.edu"))
  (setq mu4e-compose-keep-self-cc nil)
  (setq mu4e-update-interval 300)
  (setq mu4e-use-fancy-chars t)
  (setq mu4e-view-show-addresses t)
  (setq mu4e-view-show-images t)
  (setq mu4e-get-mail-command "mbsync -a") ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-sent-messages-behavior 'delete)
  (setq mu4e-headers-fields
        '( (:date          .  25)    ;; alternatively, use :human-date
           (:flags         .   6)
           (:from          .  22)
           (:subject       .  nil)))
  (setq mu4e-context-policy 'pick-first)
  (setq mu4e-compose-context-policy 'always-ask)
  (setq mu4e-maildir-shortcuts 
                     '(("/gmail/Inbox" . ?i)
                       ("/gmail/[Gmail].Sent Mail" . ?s)
                       ("/gmail/[Gmail].All Mail" . ?a)
                       ("/pesos/Inbox" . ?I)
                       ("/pesos/[pesos].Sent Mail" . ?S)
                       ("/pesos/[pesos].All Mail" . ?A)))
  (setq mu4e-contexts
        `(,(make-mu4e-context
            :name "me"
            :match-func
            (lambda (msg) (when msg
                            (string-prefix-p "/Gmail" (mu4e-message-field msg :maildir))))
            :vars `((user-mail-address . "raykar.ath@gmail.com")
                    (mu4e-compose-signature
                     . ,(concat "Atharva Raykar\n"))
                    (smtpmail-smtp-user . "raykar.ath@gmail.com")
                    (user-full-name . "Atharva Raykar")
                    (mu4e-trash-folder . "/gmail/[Gmail]/Trash")
                    (mu4e-drafts-folder . "/gmail/[Gmail]/Drafts")
                    (mu4e-sent-folder . "/gmail/[Gmail].Sent Mail")
                    (mu4e-refile-folder . "/gmail/[Gmail]/Archive")))

          ,(make-mu4e-context
            :name "pesos"
            :match-func
            (lambda (msg) (when msg
                            (string-prefix-p "/pesos" (mu4e-message-field msg :maildir))))
            :vars `((user-mail-address . "pesos@pes.edu")
                    (mu4e-compose-signature
                     . ,(concat "Atharva Raykar\n"
                                "PES Open Source"))
                    (smtpmail-smtp-user . "pesos@pes.edu")
                    (user-full-name . "PES Open Source")
                    (mu4e-trash-folder . "/pesos/[pesos]/Trash")
                    (mu4e-drafts-folder . "/pesos/[pesos]/Drafts")
                    (mu4e-sent-folder . "/pesos/[pesos].Sent Mail")
                    (mu4e-refile-folder . "/pesos/[pesos]/Archive")))))
  :defer 15)
;;  (setq mu4e-drafts-folder "/[Gmail].Drafts")
;;  (setq mu4e-sent-folder   "/[Gmail].Sent Mail")
;;  (setq mu4e-trash-folder  "/[Gmail].Trash")
;;  (setq mu4e-maildir-shortcuts
;;        '(("/Inbox" . ?i)
;;          ("/[Gmail].Sent Mail" . ?s)
;;          ("/[Gmail].Trash" . ?t)
;;          ("/[Gmail].All Mail" . ?a)))
;;  ;; something about ourselves
;;  (setq
;;   user-mail-address "raykar.ath@gmail.com"
;;   user-full-name  "Atharva Raykar"
;;   mu4e-compose-signature
;;   (concat
;;    "Atharva Raykar\n"))


(use-package org-mu4e
  :after mu4e
  :ensure nil
  :ensure-system-package mu
  :config
  (setq org-mu4e-link-query-in-headers-mode nil))

;; sending mail
(use-package smtpmail
  :ensure t
  :config
  (setq message-send-mail-function 'smtpmail-send-it
        starttls-use-gnutls t
        smtpmail-debug-info t
        smtpmail-default-smtp-server "smtp.gmail.com"
        smtpmail-smtp-server "smtp.gmail.com"
        smtpmail-smtp-service 587)
  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t))


(defun writing-tweaks ()
  (olivetti-mode 1)
  (variable-pitch-mode 1)
  (visual-line-mode 1)
  (linum-mode 0)
  (visual-fill-column-mode 1))

(add-hook 'markdown-mode-hook
          'writing-tweaks)
(add-hook 'org-mode-hook
          'writing-tweaks)

(global-linum-mode t)
(setq linum-format "%d ")
; (set-window-scroll-bars (minibuffer-window) nil nil)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
; (evil-mode 1)
; (helm-mode 1)
; (load-theme 'dracula t)
; (add-hook 'racket-mode-hook 'rainbow-delimiters-mode)
; (add-hook 'markdown-mode-hook 'writing-tweaks)
; (add-hook 'org-mode-hook 'writing-tweaks)


; (custom-set-faces
;  ;; custom-set-faces was added by Custom.
;  ;; If you edit it by hand, you could mess it up, so be careful.
;  ;; Your init file should contain only one such instance.
;  ;; If there is more than one, they won't work right.
;  '(fringe ((t (:background "#282a36"))))
;  '(info-title-1 ((t (:inherit info-title-2 :height 1.2 :family "Fira Sans"))))
;  '(info-title-2 ((t (:inherit info-title-3 :height 1.2 :family "Fira Sans"))))
;  '(info-title-3 ((t (:inherit info-title-4 :height 1.2 :family "Fira Sans"))))
;  '(info-title-4 ((t (:inherit variable-pitch :weight bold :family "Fira Sans"))))
;  '(variable-pitch ((t (:family "Fira Sans")))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(outline-1 ((t (:foreground "#ff79c6" :weight bold :height 1.3))))
 '(outline-2 ((t (:inherit outline-1 :foreground "#bd93f9" :weight normal :height 0.8))))
 '(outline-3 ((t (:inherit outline-1 :foreground "#d4b8fb" :weight normal :height 0.8))))
 '(outline-4 ((t (:inherit outline-3 :foreground "#ffa7d9"))))
 '(outline-5 ((t (:inherit outline-3 :foreground "#e4d3fc"))))
 '(outline-6 ((t (:inherit outline-3 :foreground "#ffc9e8"))))
 '(outline-7 ((t (:inherit outline-3 :foreground "#f5eefe"))))
 '(outline-8 ((t (:foreground "#dff2ff" :weight normal)))))

(setq initial-buffer-choice "~/org/todo.org")
