;; buffer handling
(global-set-key (kbd "M-u") 'previous-buffer)
(global-set-key (kbd "M-i") 'next-buffer)

;; window handling
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)

;; auto refresh buffers
(global-auto-revert-mode 1)
;; also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; start maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(provide 'modules-window-and-buffer)
