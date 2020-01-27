(add-to-list 'default-frame-alist '(font . "Inconsolata" ))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode t)
(global-linum-mode t)

(use-package doom-themes
  :diminish doom-buffer-mode
  :config
  (load-theme 'doom-fairy-floss t))

;; Set default font
(set-face-attribute 'default nil
                    :family "Inconsolata"
                    :height 170
                    :weight 'normal
		    :width 'normal)

(provide 'modules-ui)
