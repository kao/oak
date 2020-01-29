(setf custom-safe-themes t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode t)
(global-linum-mode t)
(global-hl-line-mode t)

(use-package doom-themes
  :diminish doom-buffer-mode
  :config
  (load-theme 'doom-fairy-floss t))

(add-to-list 'default-frame-alist '(font . "Inconsolata-16" ))

(provide 'oak-ui)
