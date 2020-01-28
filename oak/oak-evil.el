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

(provide 'oak-evil)
