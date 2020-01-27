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
   '("d5f8099d98174116cba9912fe2a0c3196a7cd405d12fa6b9375c55fc510988b5" "e074be1c799b509f52870ee596a5977b519f6d269455b84ed998666cf6fc802a" "6bacece4cf10ea7dd5eae5bfc1019888f0cb62059ff905f37b33eec145a6a430" "ec8246f6f74bfe0230521412d88092342c17c1c0448a4b8ba39bddd3da170590" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" "88a3c267ce2132defd46f2a4761925983dcbc35b1c3cfff1dded164ce169fed4" "72fda75af7caddec17ba9b49d2f99703c20a5f5f5c4dcec641d34a0b83569e88" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "1ed5c8b7478d505a358f578c00b58b430dde379b856fbcb60ed8d345fc95594e" "845103fcb9b091b0958171653a4413ccfad35552bc39697d448941bcbe5a660d" "0809c08440b51a39c77ec5529f89af83ab256a9d48107b088d40098ce322c7d8" "d261bb8f66be37752791a67f03dd24361592ce141b32d83bcbe63ec1c738b087" "ca849ae0c889eb918785cdc75452b1e11a00848a5128a95a23872e0119ccc8f4" "1c8171893a9a0ce55cb7706766e57707787962e43330d7b0b6b0754ed5283cda" default))
 '(golden-ratio-mode t)
 '(package-selected-packages
   '(golden-ratio docker-compose-mode undo-tree flycheck-cask elixir-mode company-go counsel-projectile all-the-icons-ivy spaceline-all-the-icons unkillable-scratch rainbow-delimiters all-the-icons spaceline go-complete go-eldoc go-mode company auto-complete go avy dumb-jump ripgrep which-key counsel ivy evil evil-escape evil-leader evil-smartparens evil-surround flx yasnippet web-mode use-package smex smartparens projectile prodigy popwin pallet nyan-mode multiple-cursors magit idle-highlight-mode htmlize expand-region exec-path-from-shell drag-stuff)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
