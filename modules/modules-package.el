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

(use-package flx)

(use-package bind-map
  :config
  (bind-map oak-base-map
    :evil-keys (oak-leader)
    :evil-states (normal motion visual)))

(use-package unkillable-scratch)

(use-package golden-ratio
  :diminish golden-ratio-mode
  :config
  (golden-ratio-mode t))

(use-package evil
  :config
  (evil-mode)
  (evil-leader/set-key ":" 'counsel-M-x)
  (define-key evil-insert-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-insert-state-map (kbd "C-a") 'beginning-of-line)
  (define-key evil-normal-state-map (kbd "C-e") 'end-of-line)
  (define-key evil-normal-state-map (kbd "C-a") 'beginning-of-line)
  (fset 'evil-visual-update-x-selection 'ignore)
  ;; (setq x-select-enable-clipboard nil)
  )

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

(use-package smartparens
  :diminish smartparens-mode
  :config
  (smartparens-global-mode)
  )

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
  (setq company-tooltip-limit 20)
  (setq company-idle-delay 2)
  (setq company-echo-delay 0)
  (setq company-begin-commands '(self-insert-command))
  )

(use-package lsp-mode
  :hook
  (go-mode . lsp-deferred)
  :commands
  (lsp lsp-deferred)
  :config
  (require 'lsp-ui)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp :commands company-lsp)

;; (use-package flycheck
;;   :init (global-flycheck-mode))

;;;; GOLANG
(use-package go-mode
  :config
  (require 'company)
  (require 'company-go)
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (custom-set-default 'lsp-clients-go-server "gopls")
  )

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :config
  (setq projectile-enable-caching t
        projectile-completion-system 'ivy
        projectile-sort-order 'recentf)
  ;; no shame
  (global-set-key (kbd "M-t") 'counsel-projectile-find-file)

  (projectile-mode)
  (counsel-projectile-mode))

(provide 'modules-package)
;;; modules-package.el ends here
