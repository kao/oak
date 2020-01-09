(require 'cask "/usr/local/share/emacs/site-lisp/cask/cask.el")
(cask-initialize)
(require 'pallet)
(pallet-mode t)

(setq gc-cons-threshold 20000000)

(add-to-list 'load-path "~/.emacs.d/modules")
(add-to-list 'load-path "~/.emacs.d/oak")
(add-to-list 'load-path "~/.emacs.d/deps")

(load "modules-system")
(load "modules-ui")

(load "oak-variable")
(load "modules-window-and-buffer")
(load "modules-package")

(load "oak-function")
(load "oak-mapping")

(defalias 'yes-or-no-p 'y-or-n-p)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("ca849ae0c889eb918785cdc75452b1e11a00848a5128a95a23872e0119ccc8f4" "1c8171893a9a0ce55cb7706766e57707787962e43330d7b0b6b0754ed5283cda" default))
 '(package-selected-packages
   '(company-go counsel-projectile all-the-icons-ivy spaceline-all-the-icons unkillable-scratch rainbow-delimiters all-the-icons spaceline go-complete go-eldoc go-mode company auto-complete go avy dumb-jump ripgrep which-key counsel ivy evil evil-escape evil-leader evil-smartparens evil-surround flx yasnippet web-mode use-package smex smartparens projectile prodigy popwin pallet nyan-mode multiple-cursors magit idle-highlight-mode htmlize flycheck-cask expand-region exec-path-from-shell drag-stuff)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
