(require 'use-package)

(use-package spaceline
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme))

(use-package all-the-icons
  :after spaceline)

(use-package spaceline-all-the-icons
  :after all-the-icons
  :config
  (spaceline-all-the-icons-theme))

(use-package all-the-icons-ivy
  :after all-the-icons
  :config
  (all-the-icons-ivy-setup))

(use-package which-key
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5)

  (which-key-mode)
  (which-key-setup-side-window-bottom))

;; popwin lets C-g close annoying kind of popups
(use-package popwin
  :config
  (popwin-mode))

(use-package flx
  :config
  (setq gc-cons-threshold 20000000))

(use-package bind-map
  :config
  (bind-map oak-base-map
    :evil-keys (oak-leader)
    :evil-states (normal motion visual)))

;;;; buffer
(use-package unkillable-scratch)

;;;; EVIL
(use-package evil
  :config
  (evil-mode)
  (evil-leader/set-key ":" 'counsel-M-x)
  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)
  (define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-normal-state-map (kbd "C-a") 'beginning-of-line))

(use-package evil-leader
  :after evil
  :config
  (progn
    (global-evil-leader-mode)
    (evil-leader/set-leader oak-leader)))

(use-package evil-escape
  :after evil
  :config
  (setq-default evil-escape-key-sequence "jk")
  (setq-default evil-escape-delay 0.2)

  (evil-escape-mode))

(use-package evil-surround
  :after evil
  :diminish global-evil-surround-mode
  :config
  (global-evil-surround-mode))

;;; EDITION
(use-package whitespace
  :diminish global-whitespace-mode
  :config
  (setq tab-width 2)
  (setq indent-tabs-mode nil)

  (setq whitespace-style '(face empty tabs lines-tail trailing))
  (setq whitespace-line-column 100)

  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  (global-whitespace-mode))

(use-package expand-region
  :config
  (setq expand-region-contract-fast-key "v"
	expand-region-reset-fast-key "r"))

(use-package rainbow-delimiters
  :diminish rainbow-delimiters-mode
  :config
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

;;;; SEARCH
(use-package ivy
  :diminish ivy-mode
  :config
  (require 'counsel)
  (setq ivy-use-virtual-buffers nil
        enable-recursive-minibuffers t
        ivy-count-format "%d/%d "
        ivy-re-builders-alist
	'((read-file-name-internal . ivy--regex-fuzzy)
	  (t . ivy--regex-plus)))

  (ivy-mode 1)
  :bind (("C-s" . swiper)
         ;;("C-<S>" . swiper-all)
         ("C-x C-f" . counsel-find-file)))

(use-package smex
  :config
  (smex-initialize))

(use-package ripgrep)
(use-package avy)
(use-package dumb-jump)

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (setq company-minimum-prefix-length 1)
  (setq company-tooltip-limit 20)                      ; bigger popup window
  (setq company-idle-delay 0)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  )

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;;;; GOLANG
(use-package go-mode
  :ensure t
  :config
  (require 'company)
  (require 'company-go)
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))
			    (company-mode)))
  (require 'go-eldoc)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'completion-at-point-functions 'go-complete-at-point)
  (setq gofmt-command "goimports")
  :hook
  (go-mode . go-eldoc-setup)
  (go-mode . flycheck-mode))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (setq projectile-enable-caching t
        projectile-completion-system 'ivy
        projectile-sort-order 'recentf)
  ;; no shame
  (global-set-key (kbd "M-t") 'counsel-projectile-find-file)

  (projectile-global-mode)
  (counsel-projectile-mode))

(provide 'modules-package)
;;; modules-package.el ends here
