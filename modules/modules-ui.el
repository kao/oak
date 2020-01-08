(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode t)
(global-linum-mode t)


(use-package doom-themes
  :diminish doom-buffer-mode
  :config
  (load-theme 'doom-tomorrow-night t))

(provide 'modules-ui)
